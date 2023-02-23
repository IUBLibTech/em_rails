class CreateImages < ActiveRecord::Migration[6.1]
  def change
    create_table :images do |t|
      t.binary :image_bytes, limit: 16777215
      t.integer :width
      t.integer :height
      t.timestamps
    end
  end
end
