class CreateArtists < ActiveRecord::Migration[5.1]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :url
      t.string :last_modified

      t.timestamps
    end
  end
end
