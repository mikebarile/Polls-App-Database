class Question < ActiveRecord::Base

  validates :text, :poll_id, presence: true

  def results

    choices = AnswerChoice.find_by_sql(<<-SQL)
      SELECT ac.*, COUNT(r.answer_choice_id) as result_count
      FROM answer_choices ac
      LEFT JOIN responses r on ac.id = r.answer_choice_id
      WHERE ac.question_id = #{self.id}
      GROUP BY 1
      SQL

    results = Hash.new(0)
    choices.each{ |choice| results[choice.choice] = choice.result_count}
    results
  end

  has_many :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :AnswerChoice

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Poll

  has_many :responses,
    through: :answer_choices,
    source: :responses
end
