class Task < ApplicationRecord
  validates :name, presence: true
  validates :detail, presence: true
  # validates :expired_at, presence: true
  # scope :by_name_search, => { where('name like ?', '%%')}
  enum status: { "選択してください": 0, "未着手": 1, "着手": 2, "完了": 3 }
end
