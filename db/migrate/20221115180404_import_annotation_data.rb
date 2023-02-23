class ImportAnnotationData < ActiveRecord::Migration[6.1]
  require 'json'
  include AnnotationsHelper


  def up
    # forgot to create the media_file_id in the annotation migration
    add_column :annotations, :media_file_id, :integer unless column_exists? :annotations, :media_file_id
    add_column :annotations, :image_id, :integer unless column_exists? :annotations, :image_id
    # something has a description that is too long for 65535 bytes - the size of the description field
    change_column :annotations, :description, :text, limit: 16777215
    change_column :annotations, :image_id, :integer, limit: 8
    import_annotations

  end

  def down
    Annotation.all.delete_all
  end
end
