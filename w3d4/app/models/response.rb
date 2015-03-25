class Response < ActiveRecord::Base
  validates :user_id, :answer_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :author_cant_respond_to_own_poll_improved

  belongs_to :answer_choice,
    class_name: 'AnswerChoice',
    foreign_key: :answer_id,
    primary_key: :id

  belongs_to :respondent,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id

  has_one :answered_question, through: :answer_choice, source: :question

  def sibling_responses
     self.answered_question.responses.where.not(id: self.id)
  end

  def sibling_responses_improved
    Response.joins(:answered_question)
            .where("answer_choices.id = ?", self.answer_id)
            .where.not(id: self.id)
  end


  private
  def respondent_has_not_already_answered_question
    if sibling_responses_improved.include?(self)
      errors[:base] << "you can't answer the same question twice"
    end
  end

  # one query
  def author_cant_respond_to_own_poll_improved
    poll_id = Poll.joins(answers: :responses)
                  .where("responses.id = ?", 1)
                  .first
                  .id

    if poll_id = self.user_id
      errors[:base] << "you can't answer your own poll"
    end
  end
  
  # three queries
  # def author_cant_respond_to_own_poll
  #   if self.answered_question.poll.author.id == self.user_id
  #     errors[:base] << "you can't answer your own poll"
  #   end
  # end

end
