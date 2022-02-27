class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 250 },
                    format: { with:  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, length: { minimum: 6 }
  validates :admin, inclusion: {in: [true, false]}
  before_destroy :make_sure_admin_exist
  before_update :make_sure_admin_exist
  
  private
  
  def make_sure_admin_exist
    if User.where(admin:true).ids.count == 1 && self.admin?
      throw(:abort) 
    end
  end
end
