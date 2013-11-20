FactoryGirl.define do
  factory :user do
    # name 'Test User'
    email 'example@example.com'
    password 'changeme'
    password_confirmation 'changeme'
    first_name 'user'
    last_name 'example'
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
