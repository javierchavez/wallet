class CreateIncomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|
      t.decimal :amount
      t.string :name

      t.timestamps null: false
    end
  end
end
