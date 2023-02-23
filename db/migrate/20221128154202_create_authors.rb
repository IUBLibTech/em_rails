class CreateAuthors < ActiveRecord::Migration[6.1]

  def up
    create_table :user_books do |t|
      t.integer :user_id
      t.integer :book_id
    end
  end

  def down
    drop_table :user_books if table_exists? :user_books
  end

end
