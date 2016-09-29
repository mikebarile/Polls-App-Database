# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(user_name: "Bob")
User.create!(user_name: "Roger")
User.create!(user_name: "Jack")
Poll.create!(title: "Best student", author_id: 1)
Question.create!(text: "Who is your favorite App Academy student?", poll_id: 1)
Question.create!(text: "Who is your least favorite App Academy student?", poll_id: 1)
AnswerChoice.create!(choice: "Justice", question_id: 1)
AnswerChoice.create!(choice: "Justice", question_id: 2)
AnswerChoice.create!(choice: "Mike", question_id: 1)
AnswerChoice.create!(choice: "Mike", question_id: 2)
Response.create!(user_id: 1, answer_choice_id: 3)
Response.create!(user_id: 2, answer_choice_id: 3)
Response.create!(user_id: 3, answer_choice_id: 1)
Response.create!(user_id: 1, answer_choice_id: 2)
Response.create!(user_id: 2, answer_choice_id: 2)
Response.create!(user_id: 3, answer_choice_id: 4)
