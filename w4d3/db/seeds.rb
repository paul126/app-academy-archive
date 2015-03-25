# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


c1 = Cat.create!(birth_date: Time.new(1978), user_id: 1, name: "Garfield", sex: "M", color: "orange", description: "Lazy and fat.")
c2 = Cat.create!(birth_date: Time.new(1994), user_id: 2, name: "Simba", sex: "M", color: "tan", description: "King of animals.")
c3 = Cat.create!(birth_date: Time.new(1963), user_id: 3, name: "Pink Panther", sex: "M", color: "striped", description: "Hardened criminal.")
c4 = Cat.create!(birth_date: Time.new(1973), user_id: 4, name: "Heathcliff", sex: "M", color: "orange", description: "Original Garfield.")

r1 = CatRentalRequest.create!(cat_id: 1,
                              user_id: 2,
                              start_date: Time.new(2015, 1, 1),
                              end_date: Time.new(2015, 1, 8),
                              status: "PENDING"
                              )
r2 = CatRentalRequest.create!(cat_id: 1,
                              user_id: 3,
                              start_date: Time.new(2015, 1, 5),
                              end_date: Time.new(2015, 1, 13),
                              status: "PENDING"
                              )
r3 = CatRentalRequest.create!(cat_id: 1,
                              user_id: 4,
                              start_date: Time.new(2015, 1, 5),
                              end_date: Time.new(2015, 1, 13),
                              status: "PENDING"
                              )
r4 = CatRentalRequest.create!(cat_id: 2,
                              user_id: 1,
                              start_date: Time.new(2015, 1, 2),
                              end_date: Time.new(2015, 1, 9),
                              status: "PENDING"
                              )
r5 = CatRentalRequest.create!(cat_id: 3,
                              user_id: 2,
                              start_date: Time.new(2015, 1, 2),
                              end_date: Time.new(2015, 1, 9),
                              status: "PENDING"
                              )
r6 = CatRentalRequest.create!(cat_id: 3,
                              user_id: 4,
                              start_date: Time.new(2015, 1, 5),
                              end_date: Time.new(2015, 1, 13),
                              status: "PENDING"
                              )


u1 = User.create!(user_name: 'user1', password: 'password1')
u2 = User.create!(user_name: 'user2', password: 'password2')
u3 = User.create!(user_name: 'user3', password: 'password3')
u4 = User.create!(user_name: 'user4', password: 'password4')
