class Question < ActiveRecord::Base
  validates :question_text, :poll_id, presence: true

  belongs_to :poll,
    class_name: 'Poll',
    foreign_key: :poll_id,
    primary_key: :id

  has_many :answer_choices,
    class_name: 'AnswerChoice',
    foreign_key: :question_id,
    primary_key: :id

  has_many :responses, through: :answer_choices, source: :responses


  #two queries
  def results1
    results = Hash.new
    answers_responses = self.answer_choices.includes(:responses)

    answers_responses.each do |answer_choice|
      results[answer_choice.choice_text] = answer_choice.responses.length
    end

    results
  end

  def answers_and_responses
    self.answer_choices.select("answer_choices.*, COUNT(r.id) AS response_count")
                       .joins("LEFT OUTER JOIN responses AS r ON answer_choices.id = r.answer_id")
                       .group("answer_choices.id")
                       .includes(:responses)
  end

  #one query
  def results
    results = Hash.new

    answers_and_responses.each do |answer_choice|
     results[answer_choice.choice_text] = answer_choice.response_count
    end

    results
  end

  def delete!
    answers_and_responses.each do |answer_choice|
      answer_choice.responses.each {|response| response.destroy!}
      answer_choice.destroy!
    end

    self.destroy!
    puts "It was destroyed :("
  end

end

#Pre - AR SQL
# SELECT
#   a.choice_text, COUNT(a.id)
# # FROM
#   questions AS q
# JOIN
#   answer_choices AS a ON q.id = a.question_id
# LEFT OUTER JOIN
#   responses AS r ON a.id = r.answer_id
# WHERE
#   q.id = self.id
# GROUP BY
#   a.id
