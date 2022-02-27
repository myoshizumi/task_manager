FactoryBot.define do
  factory :labelling do
    association :label, factory: :label
    association :task, facotry: :task
  end
end
