class ImportBookJson < ActiveRecord::Migration[6.1]
  FILE = "#{Rails.root}/tmp/books.json"

  def up
    Book.all.delete_all
    file = File.read(FILE)
    data = JSON.parse(file)
    data.each_with_index do |a, i|
      Book.create(
        id: a["book_id"], isbn: a["isbn"], title: a["book_title"].html_safe, description: a["book_description"].html_safe,
        published_date: a["published"], pages: a["pages"].to_i, buy_url: a["buy_url"], summary: a["summary"].html_safe,
        oclc: a["oclc"], table_of_contents: a["table_of_contents"].html_safe, bio_text: a["bio_text"].html_safe,
        featured: a["featured"] == "1" ? true : false, image_id: a["coverImage"].to_i, subtitle: a["book_subtitle"].html_safe
        ) if a['ready'] == "1"
      puts "Annotation #{i + 1} of #{data.size}"
    end
  end

  def down
    Book.all.delete_all
  end
end
