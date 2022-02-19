class Task < ApplicationRecord
  validates :name, presence: true
  validates :detail, presence: true
  # validates :expired_at, presence: true
  enum status: { "未着手": 1, "着手": 2, "完了": 3 }
  # scope :vague_search, -> {where('name LIKE ?', "%#{params[:task][:search]}%")}

  def self.created_order
    order(created_at: :desc)
  end


end
