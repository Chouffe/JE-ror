FactoryGirl.define do
  factory :user do
    # name 'Test User'
    sequence(:first_name)  { |n| "Person #{n}" }
    sequence(:last_name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_db_test_#{n}@example.com"}
    password 'changeme'
    password_confirmation 'changeme'
    # required if the Devise Confirmable module is used
    confirmed_at Time.now
  end
  factory :admin, class: User do
    email 'admin@admin.test'
    password 'xoxoxoxoxo'
    password_confirmation 'xoxoxoxoxo'
    first_name "Admin"
    last_name  "User"
    admin      true
    confirmed_at Time.now
  end
end
