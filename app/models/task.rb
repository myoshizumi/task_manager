class Task < ApplicationRecord
  validates :name, presence: true
  validates :detail, presence: true
  validates :expired_at, presence: true
  enum status: { "未着手": 1, "着手": 2, "完了": 3 }
  enum priority: { "高": 1, "中": 2, "低": 3}
  # scope :task_search, -> (search_params){ where('name LIKE ?', "%#{search_params}%") }
  # scope :task_status, -> (status: status_params){ where(status: status_params) }
  
  # def task_status(status_params)
  #   where(status: status_params)
  # end

  def self.created_order
    order(created_at: :desc)
  end
end
