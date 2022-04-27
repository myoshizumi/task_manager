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
require 'rails_helper'

RSpec.describe Labelling, type: :model do
end
