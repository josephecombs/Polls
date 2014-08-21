# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(:user_name => "jcombs")
User.create(:user_name => "nle")
User.create(:user_name => "nruggieri")

Poll.create(:title => "Foods", :author_id => 1)
Poll.create(:title => "Cars", :author_id => 2)
Poll.create(:title => "Sports", :author_id => 3)

Question.create(question_text: "What is your favorite breakfast?", poll_id: 1)
Question.create(question_text: "What is your favorite dinner?", poll_id: 1)

Question.create(question_text: "Your favorite make?", poll_id: 2)
Question.create(question_text: "Your favorite model?", poll_id: 2)

Question.create(question_text: "Your favorite sport?", poll_id: 3)
Question.create(question_text: "Your favorite team?", poll_id: 3)

AnswerChoice.create(answer: "Scrambled Eggs", question_id: 1)
AnswerChoice.create(answer: "Cereal", question_id: 1)
AnswerChoice.create(answer: "Bacon/Sausage", question_id: 1)
#4
AnswerChoice.create(answer: "Lentil Soup", question_id: 2)
AnswerChoice.create(answer: "Salmon", question_id: 2)
AnswerChoice.create(answer: "Ribs", question_id: 2)
#7
AnswerChoice.create(answer: "Honda", question_id: 3)
AnswerChoice.create(answer: "Ford", question_id: 3)
AnswerChoice.create(answer: "Mercedes", question_id: 3)
#10
AnswerChoice.create(answer: "NSX", question_id: 4)
AnswerChoice.create(answer: "Cobra", question_id: 4)
AnswerChoice.create(answer: "SLS", question_id: 4)

Response.create(user_id: 1, answer_choice_id: 2)
Response.create(user_id: 1, answer_choice_id: 5)
Response.create(user_id: 2, answer_choice_id: 2)
Response.create(user_id: 1, answer_choice_id: 9)
Response.create(user_id: 2, answer_choice_id: 7)
Response.create(user_id: 3, answer_choice_id: 8)
Response.create(user_id: 1, answer_choice_id: 12)
Response.create(user_id: 2, answer_choice_id: 10)

