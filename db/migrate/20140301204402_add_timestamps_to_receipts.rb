class AddTimestampsToReceipts < ActiveRecord::Migration
  def change
    change_table :receipts do |t|
      t.timestamps
    end
  end
end
