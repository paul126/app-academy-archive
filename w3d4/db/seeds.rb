# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

usr1 = User.create!(user_name: "charizardboy1")
usr2 = User.create!(user_name: "venusaurgirl2")
usr3 = User.create!(user_name: "professoroak3")

poll1 = Poll.create!(title: "Fire PokePoll1", author: usr1)
poll2 = Poll.create!(title: "Grass PokePoll2", author: usr2)

qF1 = Question.create!(question_text: "What's the best fire pokemon?",
                      poll_id: poll1.id)
qF2 = Question.create!(question_text: "What does fire beat?",
                      poll_id: poll1.id)
qG1 = Question.create!(question_text: "What's the best grass pokemon?",
                      poll_id: poll2.id)
qG2 = Question.create!(question_text: "What does grass beat?",
                      poll_id: poll2.id)
qG3 = Question.create!(question_text: "Where can I find the Moon Stone?",
                      poll_id: poll2.id)

acF1a = AnswerChoice.create!(choice_text: "Charizard", question_id: qF1.id)
acF1b = AnswerChoice.create!(choice_text: "Growlithe", question_id: qF1.id)
acF2a = AnswerChoice.create!(choice_text: "Water", question_id: qF2.id)
acF2b = AnswerChoice.create!(choice_text: "Grass", question_id: qF2.id)

acG1a = AnswerChoice.create!(choice_text: "Venusaur", question_id: qG1.id)
acG1b = AnswerChoice.create!(choice_text: "Victreebell", question_id: qG1.id)
acG2a = AnswerChoice.create!(choice_text: "Water", question_id: qG2.id)
acG2b = AnswerChoice.create!(choice_text: "Fire", question_id: qG2.id)
acG3a = AnswerChoice.create!(choice_text: "Mount Moon", question_id: qG3.id)
acG3b = AnswerChoice.create!(choice_text: "Veridian City", question_id: qG3.id)

usr1r1 = Response.create!(user_id: usr1.id, answer_id: acG1a.id)
usr1r2 = Response.create!(user_id: usr1.id, answer_id: acG2a.id)

usr2r1 = Response.create!(user_id: usr2.id, answer_id: acF1a.id)
usr2r2 = Response.create!(user_id: usr2.id, answer_id: acF2a.id)

usr3r1 = Response.create!(user_id: usr3.id, answer_id: acF1a.id)
usr3r2 = Response.create!(user_id: usr3.id, answer_id: acF2b.id)
usr3r3 = Response.create!(user_id: usr3.id, answer_id: acG1a.id)
usr3r4 = Response.create!(user_id: usr3.id, answer_id: acG2a.id)
usr3r4 = Response.create!(user_id: usr3.id, answer_id: acG3a.id)
