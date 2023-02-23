class Annotation < ApplicationRecord
  require "mini_magick"
  belongs_to :book

  MEDIA_TYPES = ["video", "audio", "image"]
  THUMB_SIZES = {
    "small" => "160x107",
    "large" => "360x240"
  }

  def image_name
    "#{image_id}.jpg"
  end

  def image_thumb_name(size = THUMB_SIZES["small"])
    if size == THUMB_SIZES["small"] || size == "small"
      "thumb_#{image_id}.jpg"
    else
      "thumb_#{image_id}_large.jpg"
    end
  end

  def streamable?
    return media_type == "video" || media_type == "audio"
  end

  def self.generate_image_thumbnails
    ias = Annotation.where(media_type: "image")
    ias.each do |ia|
      THUMB_SIZES.keys.each do |key|
        dir = "#{Rails.root}/app/assets/images"
        source = "#{dir}/#{ia.image_name}"
        image = MiniMagick::Image.open(source)
        image.resize THUMB_SIZES[key]
        image.format "jpg"
        dest = "#{dir}/#{ia.image_thumb_name(THUMB_SIZES[key])}"
        if File.exist? dest
          File.delete dest
        end
        image.write dest
        raise "Did not create thumbnail image: #{dest}" unless File.exist? "#{dest}"
        puts "Wrote #{dest}"
      end
    end
  end

end
