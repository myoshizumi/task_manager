# coding: utf-8

# User.create(name: "No", email: "more@errors.com", password_digest: "anymore")
User.create(name: "No",
    email: "nomore@errors.com",
    password: "anymore",
    password_confirmation: "anymore",
    admin: false)
User.create(name: "Admin",
    email: "no@errors.com",
    password: "nomore",
    password_confirmation: "nomore",
    admin: false)
User.create(name: "mine",
    email: "no@more.com",
    password: "noerror",
    password_confirmation: "noerror",
    admin: true)

