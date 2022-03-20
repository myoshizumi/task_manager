# frozen_string_literal: true

FactoryBot.define do
  factory :labelling do
    association :label, factory: :label
    association :task, facotry: :task
  end
end
