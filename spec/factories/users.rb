# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  admin           :boolean          default(FALSE), not null
#
FactoryBot.define do
  factory :user do
    name { 'user' }
    sequence(:email) { |n| "more#{n}@example.com" }
    password { 'anymore' }
    password_confirmation { 'anymore' }
    admin { false }
  end
  factory :admin, class: User do
    name { 'admin' }
    sequence(:email) { |n| "no#{n}@errors.com" }
    password { 'nomore' }
    password_confirmation { 'nomore' }
    admin { true }
  end
  factory :user_a, class: User do
    name { 'user_a' }
    email { 'a@a.a' }
    password { 'anymore' }
    password_confirmation { 'anymore' }
    admin { false }
  end
end
