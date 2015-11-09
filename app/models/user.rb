class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :categories
  has_many :transactions
  has_many :incomes
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_save :init_user
  
  def init_user
    # needs to be checked if new_record? instead
    if categories.size < 2
      categories.create!(:name => "Uncategorized")
      categories.create!(:name => "Food & Dining")
    end
  end
end
