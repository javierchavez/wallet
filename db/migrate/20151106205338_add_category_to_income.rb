class AddCategoryToIncome < ActiveRecord::Migration
  def change
    add_reference :incomes, :category, index: true, foreign_key: true
  end
end
