class AddDateToReceipt < ActiveRecord::Migration
  def change
    change_table :receipts do |t|
      t.date :receipt_date
    end
  end
end
