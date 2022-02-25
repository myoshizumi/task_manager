FactoryBot.define do
  factory :user do 
    name { "user" }
    sequence(:email){ |n| "more#{n}@example.com" }
    password { "anymore" }
    password_confirmation { "anymore" }
    admin { false }
  end
  factory :admin ,class: User do
    name { "admin" }
    sequence(:email) { |n| "no#{n}@errors.com" }
    password { "nomore" }
    password_confirmation { "nomore" }
    admin { true }
  end
  factory :user_a ,class: User do 
    name { "user_a" }
    email { "a@a.a"}
    password { "anymore" }
    password_confirmation { "anymore" }
    admin { false }
  end
end
# name { "User" }
# sequence(:email){ |n| "nomore#{n}@errors.com" }
# password { "anymore" }
# password_confirmation { "anymore" }
# admin { false }
# end
# factory :admin ,class: User do
# name { "Admin" }
# sequence(:email){ |n| "no#{n}@errors.com" }
# password { "nomore" }
# password_confirmation { "nomore" }
# admin { true }