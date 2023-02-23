class ImportAuthors < ActiveRecord::Migration[6.1]
  require 'csv'
  def up
    unless table_exists? :user_books
      create_table :user_books do |t|
        t.integer :user_id
        t.integer :book_id
        t.timestamps
      end
    end

    UserBook.all.delete_all
    # import user book data
    CSV.foreach("#{Rails.root}/tmp/author_to_book.csv", headers: true) do |row|
      user = User.where(id: row['userid'].to_i).first
      book = Book.where(id: row['book_id'].to_i).first
      raise "Failed to find user with id: #{row['userid'].to_i}" if user.nil?
      raise "Failed to find book with id: #{row['book_id'].to_i}" if book.nil?
      user.author_user = true
      user.save!
      UserBook.new(user: user, book: book).save!
    end
  end

  def down
    drop_table :user_books
  end
end
