class CreateMotives < ActiveRecord::Migration
  def change
    create_table :motives do |t|
      t.integer :number
      t.string :description
      t.timestamps
    end
  end
end
