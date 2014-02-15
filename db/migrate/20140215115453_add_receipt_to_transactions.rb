class AddReceiptToTransactions < ActiveRecord::Migration
  def change
    change_table :transactions do |t|
      t.references :receipt
    end
  end
end
