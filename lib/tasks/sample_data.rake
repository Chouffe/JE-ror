namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    99.times do |n|
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      u = User.new(first_name: first_name,
                   last_name: last_name,
                   email: email,
                   password: password,
                   password_confirmation: password)
      u.skip_confirmation!
      u.save!
    end
  end
end
