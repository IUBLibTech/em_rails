class GenBookThumbnails < ActiveRecord::Migration[6.1]
  def up
    Book.generate_book_thumbnails
  end

  def down
    # do nothing as generating thumbnails will delete all existing ones first
  end
end
