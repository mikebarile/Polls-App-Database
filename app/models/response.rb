class Response < ActiveRecord::Base

  validates :user_id, :answer_choice_id, presence: true
  validate :author_cant_respond, :not_duplicate_response

  def author_cant_respond
    if poll.author_id == user_id
      errors[:base] << 'Error: author cant respond to own poll'
    end
  end

  def not_duplicate_response
    responses = Response.where(user_id: user_id).includes(:question)
    duplication = false
    responses.each{ |t| duplication = true if t.question == question }
    errors[:base] << 'Error: duplicate response' if duplication
  end

  def sibling_responses
    responses = question.responses.where.not(id: id)
  end

  def respondent_already_answered?
    sibling_responses.any?{ |t| t.id == id}
  end

  has_one :poll,
    through: :answer_choice,
    source: :poll

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: :AnswerChoice

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_one :question,
    through: :answer_choice,
    source: :question

end
