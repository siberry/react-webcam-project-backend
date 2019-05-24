class CreateWebcams < ActiveRecord::Migration[5.2]
  def change
    create_table :webcams do |t|
      t.string :title
      t.string :player_url
      t.string :img_url
      t.integer :api_id
      t.boolean :featured, :default => false
      t.string :country
      t.string :continent
      t.string :town
      t.string :region

      t.timestamps
    end
  end
end
