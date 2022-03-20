# frozen_string_literal: true

FactoryBot.define do
  factory :label do
    name { 'private' }
  end
  factory :label_second, class: Label do
    name { 'family' }
  end
end
