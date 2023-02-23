class ImportBookPresses < ActiveRecord::Migration[6.1]

  FILE = "#{Rails.root}/tmp/book_presses.json"

  def up
    file = File.read(FILE)
    data = JSON.parse(file)
    data.each_with_index do |a, i|
      book = Book.find(a['book_id'].to_i)
      book.press = a['press_name']
      book.save!
      puts "Book Press #{i + 1} of #{data.size}"
    end
  end

  def down

  end
end
