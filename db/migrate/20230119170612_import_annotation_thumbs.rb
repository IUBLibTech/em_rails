class ImportAnnotationThumbs < ActiveRecord::Migration[6.1]
  include AnnotationsHelper

  def up
    import_thumbs
  end

  def down

  end

end
