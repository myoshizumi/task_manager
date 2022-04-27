# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  detail     :text             not null
#  created_at :datetime
#  updated_at :datetime
#  expired_at :datetime
#  status     :integer
#  priority   :integer
#  user_id    :bigint           not null
#
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
