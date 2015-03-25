class Poll < ActiveRecord::Base

  validates :title, :author, :presence => true

  belongs_to :author,
    class_name: 'User',
    foreign_key: :author,
    primary_key: :id

  has_many :questions,
    class_name: 'Question',
    foreign_key: :poll_id,
    primary_key: :id

  has_many :answers, through: :questions, source: :answer_choices

  def self.all_questions_and_responses
    self.joins("JOIN questions AS q ON polls.id = q.poll_id")
    .joins("JOIN answer_choices AS a ON q.id = a.question_id")
    .joins("LEFT OUTER JOIN responses AS r ON a.id = r.answer_id")
  end
end
