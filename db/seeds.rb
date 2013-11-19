# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'USERS'
User.create :email => ENV["GMAIL_USERNAME"], :password => 'topsecret', :password_confirmation => 'topsecret', :first_name => 'Chuck', :last_name => 'Norris'
puts 'Admin created'
