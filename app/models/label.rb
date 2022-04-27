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
class Label < ApplicationRecord
  has_many :labellings, dependent: :destroy
  has_many :tasks, through: :labellings
end
