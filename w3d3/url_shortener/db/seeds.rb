# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!([{ email: 'test1@test.com'},{ email: 'test2@test.com'},{ email: 'test3@test.com'}])

test1 = ShortenedUrl.create!({user_id: 1, long_url: "test1.com", short_url: ShortenedUrl.random_code})
test2 = ShortenedUrl.create!({user_id: 2, long_url: "test2.com", short_url: ShortenedUrl.random_code})
test3 = ShortenedUrl.create!({user_id: 3, long_url: "test3.com", short_url: ShortenedUrl.random_code})
test4 = ShortenedUrl.create!({user_id: 2, long_url: "test4.com", short_url: ShortenedUrl.random_code})

visit1 = Visit.create!({short_url_id: test1.id, user_id:1})
visit2 = Visit.create!({short_url_id: test2.id, user_id:1})
visit3 = Visit.create!({short_url_id: test3.id, user_id:1})
visit4 = Visit.create!({short_url_id: test4.id, user_id:1})
visit5 = Visit.create!({short_url_id: test1.id, user_id:2})
visit6 = Visit.create!({short_url_id: test1.id, user_id:3})
visit7 = Visit.create!({short_url_id: test2.id, user_id:2})
vitit8 = Visit.create!({short_url_id: test2.id, user_id:2})

TagTopic.create!([{tag: 'Sports1'}, {tag: 'Movies2'}, {tag: 'Music3'}, {tag: 'News4'}, {tag: 'Food5'}])


Tagging.create!([{short_url_id: 1, tag_id:1},{short_url_id: 2, tag_id:2},{short_url_id: 3, tag_id:3}])
Tagging.create!({short_url_id: 1, tag_id:2})
