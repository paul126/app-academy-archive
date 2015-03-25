class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true

  has_many :authored_polls,
    class_name: "Poll",
    foreign_key: :author,
    primary_key: :id

  has_many :responses,
    class_name: "Response",
    foreign_key: :user_id,
    primary_key: :id

  has_many :answered_questions, through: :responses, source: :answered_question
  has_many :answered_polls, -> { distinct },
            through: :answered_questions, source: :poll


  def completed_polls
    Poll.all_questions_and_responses
        .where("r.user_id = ? OR r.user_id IS NULL", self.id)
        .group("polls.id")
        .having("COUNT(DISTINCT q.id) = COUNT(r.id)")
  end

  def incomplete_polls
    Poll.all_questions_and_responses
        .where("(r.user_id = :id OR r.user_id IS NULL)
                AND polls.author != :id", id: self.id)
        .group("polls.id")
        .having("COUNT(DISTINCT q.id) > COUNT(r.id)")
  end

end


# def completed_polls_error
#   Poll.joins("JOIN questions AS q ON polls.id = q.poll_id")
#       .joins("JOIN answer_choices AS a ON q.id = a.question_id")
#       .joins("LEFT OUTER JOIN (#{Response.where(user_id: self.id).to_sql}) AS r
#               ON a.id = r.answer_id")
#       .group("polls.id")
#       .having("COUNT(DISTINCT q.id) = COUNT(r.id)")
# end
#
# def completed_polls_subquery_injection
#   Poll.joins("JOIN questions AS q ON polls.id = q.poll_id")
#       .joins("JOIN answer_choices AS a ON q.id = a.question_id")
#       .joins("LEFT OUTER JOIN
#                     (SELECT
#                       *
#                      FROM
#                       responses
#                      WHERE
#                       responses.user_id = #{self.id}) AS r
#                      ON
#                       a.id = r.answer_id")
#       .group("polls.id")
#       .having("COUNT(DISTINCT q.id) = COUNT(r.id)")
# end

#
# SELECT
#   p.*
# FROM
#   polls AS p
# JOIN
#   questions AS q
# ON
#   p.id = q.poll_id
# JOIN
#   answer_choices AS a
# ON
#   q.id = a.question_id
# LEFT OUTER JOIN
#   (SELECT
#     *
#    FROM
#     responses
#    WHERE
#     responses.user_id = 2) AS r
# ON
#   a.id = r.answer_id
# GROUP BY
#   p.id
# HAVING
#   COUNT(DISTINCT q.id) = COUNT(r.id)

#
# SELECT
#   p.*
# FROM
#   polls AS p
# JOIN
#   questions AS q
# ON
#   p.id = q.poll_id
# JOIN
#   answer_choices AS a
# ON
#   q.id = a.question_id
# LEFT OUTER JOIN
#   responses AS r
# ON
#   a.id = r.answer_id
# WHERE
#  r.user_id = 2 OR r.user_id IS NULL
# GROUP BY
#   p.id
# HAVING
#   COUNT(DISTINCT q.id) = COUNT(r.id)
