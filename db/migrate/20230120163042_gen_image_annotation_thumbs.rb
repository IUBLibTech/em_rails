class GenImageAnnotationThumbs < ActiveRecord::Migration[6.1]
  def change
    Annotation.generate_image_thumbnails
  end
end
