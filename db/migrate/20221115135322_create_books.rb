class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|

      t.string :isbn
      t.string :title
      t.text :description, limit: 16777215
      t.string :published_date
      t.integer :pages
      t.string :buy_url
      t.text :summary, limit: 16777215
      t.string :oclc
      t.text :table_of_contents, limit: 16777215
      t.text :bio_text,  limit: 16777215
      t.boolean :featured
      t.integer :image_id
      t.string :press
      t.text :subtitle

      t.timestamps
    end
  end
end
