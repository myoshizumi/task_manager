class Task < ApplicationRecord
  validates :name, presence: true
  validates :detail, presence: true
  # validates :expired_at, presence: true
end
