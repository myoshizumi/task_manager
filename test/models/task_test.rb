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
require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
