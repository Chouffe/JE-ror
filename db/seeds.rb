# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'USERS'
u = User.new :email => ENV["GMAIL_USERNAME"], :password => 'topsecret', :password_confirmation => 'topsecret', :first_name => 'Chuck', :last_name => 'Norris'
u.skip_confirmation!
u.save
puts 'User Chuck Norris created'
u = User.new :email => ENV["ADMIN_EMAIL"], :password => ENV["ADMIN_PASSWORD"], :password_confirmation => ENV["ADMIN_PASSWORD"], :first_name => ENV["ADMIN_USERNAME"], :last_name => ENV["ADMIN_USERNAME"], :admin => true
u.skip_confirmation!
u.save
puts 'Admin created'
