class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.string :receipt_number
      t.string :donor_name
      t.text :donor_address
      t.text :line_items
    end
  end
end
