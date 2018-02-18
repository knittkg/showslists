class CreateShowslists < ActiveRecord::Migration[5.1]
  def change
    create_table :showslists do |t|
      t.string :live_date
      t.string :live_place
      t.string :live_pref
      t.datetime :last_modified
      t.string :filename
      t.string :name
      t.string :title
      t.integer :length
      t.integer :playtime

      t.timestamps
    end
  end
end
