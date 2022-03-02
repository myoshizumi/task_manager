# coding: utf-8
10.times do |n|
    User.create(name: "Admin",
        email: "none#{n+50}@errors.com",
        password: "nomore",
        password_confirmation: "nomore",
        admin: false)
    end
User.create(name: "mine",
    email: "nonenone@more.com",
    password: "noerror",
    password_confirmation: "noerror",
    admin: false)


User.all.each do |user|
    10.times do |n|
    user.tasks.create!(user_id: User.ids, 
    name: "Task", 
    detail: "Detail",
    expired_at: '01/01')
    end
end

    
Label.create(name: "Work")
Label.create(name: "Private")
Label.create(name: "School")
Label.create(name: "Community")
Label.create(name: "Family")
