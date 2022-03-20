# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
  validates :name, presence: true
  validates :detail, presence: true
  validates :expired_at, presence: true
  enum status: { "未着手": 1, "着手": 2, "完了": 3 }
  enum priority: { "高": 1, "中": 2, "低": 3 }
  scope :task_search, ->(search_params) { where('tasks.name LIKE ?', "%#{search_params}%") }
  scope :task_status, ->(status_params) { where(status: status_params) }
  scope :task_label, ->(label_params) { where(labels: { id: label_params }) }
  def self.created_order
    order(created_at: :desc)
  end
end
