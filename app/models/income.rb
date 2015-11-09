class Income < ActiveRecord::Base
  validates :name, presence: true
  validates :amount, presence: true, numericality: true
  belongs_to :user
  belongs_to :category
  
end
