class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :name
      t.references :category, index: true, foreign_key: true
      t.decimal :amount

      t.timestamps null: false
    end
  end
end
