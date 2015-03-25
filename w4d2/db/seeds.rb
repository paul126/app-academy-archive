# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


c1 = Cat.create!(birth_date: Time.new(1978), name: "Garfield", sex: "M", color: "orange", description: "Lazy and fat.")
c2 = Cat.create!(birth_date: Time.new(1994), name: "Simba", sex: "M", color: "tan", description: "King of animals.")
c3 = Cat.create!(birth_date: Time.new(1963), name: "Pink Panther", sex: "M", color: "striped", description: "Hardened criminal.")
c4 = Cat.create!(birth_date: Time.new(1973), name: "Heathcliff", sex: "M", color: "orange", description: "Original Garfield.")

r1 = CatRentalRequest.create!(cat_id: 1,
                              start_date: Time.new(2015, 1, 1),
                              end_date: Time.new(2015, 1, 8),
                              status: "PENDING"
                              )
r2 = CatRentalRequest.create!(cat_id: 1,
                              start_date: Time.new(2015, 1, 5),
                              end_date: Time.new(2015, 1, 13),
                              status: "PENDING"
                              )
r3 = CatRentalRequest.create!(cat_id: 1,
                              start_date: Time.new(2015, 1, 5),
                              end_date: Time.new(2015, 1, 13),
                              status: "PENDING"
                              )
r4 = CatRentalRequest.create!(cat_id: 2,
                              start_date: Time.new(2015, 1, 2),
                              end_date: Time.new(2015, 1, 9),
                              status: "PENDING"
                              )
r5 = CatRentalRequest.create!(cat_id: 3,
                              start_date: Time.new(2015, 1, 2),
                              end_date: Time.new(2015, 1, 9),
                              status: "PENDING"
                              )
r6 = CatRentalRequest.create!(cat_id: 3,
                              start_date: Time.new(2015, 1, 5),
                              end_date: Time.new(2015, 1, 13),
                              status: "PENDING"
                              )
