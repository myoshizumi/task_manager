# coding: utf-8

User.create(name: "Admin",
    email: "none@errors.com",
    password: "nomore",
    password_confirmation: "nomore",
    admin: false)
User.create(name: "mine",
    email: "noneno@more.com",
    password: "noerror",
    password_confirmation: "noerror",
    admin: false)

3.times do |i|
    Task.create(user_id: User.find(i+1).id, 
    name: "Task #{i+1}", 
    detail: "Detail #{i+1}",
    expired_at: '01/01')
end

    
# Label.create(name: "Work")
# Label.create(name: "Private")
# Label.create(name: "School")
# Label.create(name: "Community")
# Label.create(name: "Family")
