class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :receipt_number
      t.references :donor
      t.references :motive
      t.date :receipt_date
      t.decimal :amount
      t.timestamps
    end
  end
end
