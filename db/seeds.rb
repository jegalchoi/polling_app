# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Poll.destroy_all
Question.destroy_all
AnswerChoice.destroy_all
Response.destroy_all

ApplicationRecord.connection.reset_pk_sequence!('users')
ApplicationRecord.connection.reset_pk_sequence!('polls')
ApplicationRecord.connection.reset_pk_sequence!('questions')
ApplicationRecord.connection.reset_pk_sequence!('answer_choices')
ApplicationRecord.connection.reset_pk_sequence!('responses')

ActiveRecord::Base.transaction do
  u1 = User.create!(username: 'jay')
  u2 = User.create!(username: 'cam')
  u3 = User.create!(username: 'mom')

  p1 = Poll.create!(title: 'favorite', author_id: 1)
  p2 = Poll.create!(title: 'restaurant', author_id: 3)
  p3 = Poll.create!(title: 'sport', author_id: 3)

  q1 = Question.create!(text: 'color?', poll_id: 1)
  q2 = Question.create!(text: 'day?', poll_id: 1)
  
  q3 = Question.create!(text: 'customer service?', poll_id: 2)

  a1 = AnswerChoice.create!(text: 'black', question_id: 1)
  a2 = AnswerChoice.create!(text: 'white', question_id: 1)
  a3 = AnswerChoice.create!(text: 'green', question_id: 1)

  a4 = AnswerChoice.create!(text: 'excellent', question_id: 3)
  a5 = AnswerChoice.create!(text: 'good', question_id: 3)
  a6 = AnswerChoice.create!(text: 'poor', question_id: 3)

  a7 = AnswerChoice.create!(text: 'Mon', question_id: 2)
  a8 = AnswerChoice.create!(text: 'Tue', question_id: 2)
  a9 = AnswerChoice.create!(text: 'Wed', question_id: 2)

  r1 = Response.create!(answer_choice_id: 1, user_id: 2)
  r2 = Response.create!(answer_choice_id: 3, user_id: 3)
  
  
end