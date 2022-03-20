# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    association :user
    name { 'test_name' }
    detail { 'test_detail' }
    expired_at { '01/01 11:11' }
    status { '完了' }
    priority { '高' }
  end
end
