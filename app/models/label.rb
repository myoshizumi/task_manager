class Label < ApplicationRecord
  has_many :labellings, dependent: :delete_all
  has_many :tasks, through: :labellings
end
