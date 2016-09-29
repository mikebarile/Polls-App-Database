class User < ActiveRecord::Base

  validates :user_name, presence: true, uniqueness: true

  def completed_polls
    Poll.find_by_sql(<<-SQL)
      SELECT p.*
      FROM polls p
      JOIN questions q on p.id = q.poll_id
      JOIN answer_choices ac on ac.question_id = q.id
      LEFT JOIN responses r on r.answer_choice_id = ac.id
        AND r.user_id = #{self.id}
      GROUP BY p.id
      HAVING count(distinct q.id) = count(r.user_id)
    SQL
  end

  has_many :authored_polls,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Poll

  has_many :responses,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Response


end
