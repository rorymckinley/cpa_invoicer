class AddAdressToDonors < ActiveRecord::Migration
  def change
    change_table :donors do |t|
      t.string :address1
      t.string :address2
      t.string :town
      t.string :postal_code
      t.string :email
    end
  end
end
