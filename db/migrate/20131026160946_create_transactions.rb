class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :receipt_number
      t.references :donor
      t.references :motive
      t.date :receipt_date
      t.decimal :amount, precision: 15, scale: 2
      t.timestamps
    end
  end
end
