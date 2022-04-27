# frozen_string_literal: true

# == Schema Information
#
# Table name: labellings
#
#  id         :bigint           not null, primary key
#  task_id    :bigint           not null
#  label_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :labelling do
    association :label, factory: :label
    association :task, facotry: :task
  end
end
