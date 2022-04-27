# frozen_string_literal: true

# == Schema Information
#
# Table name: labels
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :label do
    name { 'private' }
  end
  factory :label_second, class: Label do
    name { 'family' }
  end
end
