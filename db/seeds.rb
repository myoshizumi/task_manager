# coding: utf-8

User.create(name: "Admin",
    email: "no2@errors.com",
    password: "nomore",
    password_confirmation: "nomore",
    admin: false)
User.create(name: "mine",
    email: "no@more.com",
    password: "noerror",
    password_confirmation: "noerror",
    admin: true)

Label.create(name: "Work")
Label.create(name: "Private")
Label.create(name: "School")
Label.create(name: "Community")
Label.create(name: "Family")
