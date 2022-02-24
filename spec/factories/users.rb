FactoryBot.define do
  factory :user do 
    name { "user" }
    sequence(:email){ |n| "nomore#{n}@errors.com" }
    password { "anymore" }
    password_confirmation { "anymore" }
    admin { false }
    # association :task
  end
  factory :admin ,class: User do
    name { "admin" }
    sequence(:email){ |n| "no#{n}@errors.com" }
    password { "nomore" }
    password_confirmation { "nomore" }
    admin { true }
    # association :task
  end
end
# name { "User" }
# sequence(:email){ |n| "nomore#{n}@errors.com" }
# password { "anymore" }
# password_confirmation { "anymore" }
# admin { false }
# # association :task
# end
# factory :admin ,class: User do
# name { "Admin" }
# sequence(:email){ |n| "no#{n}@errors.com" }
# password { "nomore" }
# password_confirmation { "nomore" }
# admin { true }
# association :task