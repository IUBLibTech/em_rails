class CreateAnnotations < ActiveRecord::Migration[6.1]
  def change
    create_table :annotations do |t|
      t.integer :book_id
      t.text :title
      t.text :description, limit: 65535
      # book page this annotation is referenced
      t.string :page_reference

      # this determines whether the annotation is for a video file, audio file, or image file
      t.string :media_type

      # whether the annotation should randomly appear in the 'samples' section of the webapp
      t.boolean :sample

      # all audio/video content is streamed through MCO - only images should have this as null
      t.boolean :avalon_segment
      # the MCO embeddable iframe URL
      t.string :avalon_purl
      t.integer :image_id, limit: 8
      t.integer :thumb_id, limit: 8
      t.timestamps
    end
  end
end
