class Category < ActiveRecord::Base
  has_many :transactions
  has_many :incomes
  
  belongs_to :user
  validates :name, presence: true




  

  # Mainly to add the functionality of sum
  # fucntions.
  #
  def as_json(options={})
    # .reject { |k, v| v.nil? }
    result = super(options)
    if options.has_key?(:total)
      result["total"] = sum_t.to_f
    end
    
    result
  end

  # Returns a Google Array data table without the headers
  # the data is category name and the total amount 
  # spent in that category
  #
  def self.as_array_table
    result = []
    result.push(['Category', 'Amount'])
    data = []
    
    # find_each limits to 1000
    Category.find_each do |x|
      data.push( x.as_json(only: [:name, :amount], total: true).values )
    end
    result.concat(data)
  end

  # Returns the total amount for this category
  #
  def sum_i
    incomes.each.inject(BigDecimal.new(0)) do |total, val|
      total += val.amount
    end
  end


  # Returns the total spent for the category
  # 
  def sum_t
    transactions.each.inject(BigDecimal.new(0)) do |total, val|
      total += val.amount
    end
  end
end
