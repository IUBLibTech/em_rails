class Book < ApplicationRecord
  require "mini_magick"
  LOCATION = "#{Rails.root}/app/assets/images"

  has_many :user_books, optional: true
  has_many :users, through: :user_books
  has_many :annotations

  THUMB_SIZES = ["small", 'medium', 'large']
  THUMB_SIZE_DIMENSIONS = {
    "small" => "96x160>",
    "medium" => "133x200>",
    "large" => "266x400>"
  }

  searchable do
    text :title
    text :description
    text :authors do
      users.map {|u| u.full_name }
    end
    text :annotation do
      annotations.map {|a| "#{a.title} #{a.description}"}
    end
  end

  # def self.search(text)
  #   Book.joins(:users, :annotations).where(
  #      "(books.title like ? OR books.description like ?) OR "+
  #        "((users.first_name like ? OR users.middle_name like ? OR users.last_name like ?) AND users.author_user = true) OR"+
  #        "(annotations.title like ? OR annotations.description like ?)", "%#{text}%", "%#{text}%", "%#{text}%", "%#{text}%", "%#{text}%", "%#{text}%", "%#{text}%"
  #    )
  # end

  def self.solr_search(field)
    ai = Book.search do
      fulltext field
    end
    ai.results
  end

  def authors
    users.order(:last_name)
  end

  def author_names
    authors.collect{|a| a.full_name }
  end
  # whenever called, this method first determines whether a thumbnail image of the book cover exists. If it does not, it
  # creates that thumbnail in the assets/images directory and returns the name of the thumbnail file
  def thumbnail(size)
    Book.valid_thumbnail_size? size
    short = "thumb_#{image_id}_#{size}.jpg"
    file = "#{LOCATION}/#{short}"
    unless File.exists? file
      Book.generate_thumbnail(size, id)
    end
    short
  end

  def thumbnail_small
    thumbnail("small")
  end

  def thumbnail_med
    thumbnail("medium")
  end

  def thumbnail_large
    thumbnail("large")
  end

  def self.generate_thumbnail(size = 'medium', b )
    Book.valid_thumbnail_size? size
    puts "Creating thumbnail size: #{size} for Book #{b.title}"
    thumb = "#{LOCATION}/thumb_#{b.image_id}_#{size}.jpg"
    if File.exists? thumb
      File.delete(thumb)
    end
    source = "#{LOCATION}/#{b.image_id}.jpg"
    raise "\tSource DOES NOT EXIST" unless File.exist? source
    image = MiniMagick::Image.open(source)

    image.resize THUMB_SIZE_DIMENSIONS[size]
    image.format "jpg"
    image.write thumb
    raise "Did not create thumbnail image: #{thumb}" unless File.exist? thumb
  end

  def self.valid_thumbnail_size?(size)
    raise "Unsupported thumbnail size. Must be one of #{THUMB_SIZES.join(', ')}" unless THUMB_SIZES.include? size
  end

  # this method RE-generates all book cover thumbnails
  def self.generate_book_thumbnails
    Book.all.each do |b|
      THUMB_SIZES.each do |size|
        generate_thumbnail(size, b)
      end
    end
  end

  def temple?
    press.include? "Temple"
  end

  def iu?
    press.include? "Indiana"
  end

  def published_year
    published_date.split('/').last
  end

  def videos
    annotations.where(media_type: "video")
  end
  def audio
    annotations.where(media_type: "audio")
  end
  def images
    annotations.where(media_type: "image")
  end

end
