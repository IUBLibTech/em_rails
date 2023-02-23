class ImportAnnotationThumbs < ActiveRecord::Migration[6.1]
  include AnnotationsHelper

  def up
    add_column :annotations, :thumb_id, :integer unless column_exists? :annotations, :thumb_id
    import_thumbs
  end

  def down
    remove_column :annotations, :thumb_id
  end

end
