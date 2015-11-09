class Transaction < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  validates :name, presence: true
  validates :amount, presence: true, numericality: true
  
  # validates :category_id, presence: true

  # this is supposedly deprecated
  before_save :check_money

  
  protected

  # Check if there are available funds
  #
  def check_money
    total = category.sum_i
    
    if category.sum_i > amount
      true
    else
      errors[:base] << "You dont have enough money in #{category.name} budget"
      false
    end
  end

end
