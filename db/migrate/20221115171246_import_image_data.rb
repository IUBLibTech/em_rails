class ImportImageData < ActiveRecord::Migration[6.1]
  # The original app stored image files in the mysql database 'image_file' file table. This migration file is responsible
  # for reconstituting that binary data into files on the file system but in order to run it, the original table must
  # exist and be populated with tis contents prior to running this migration. There should be a dump file in the tmp
  # directory to import from.
  def up
    raise "Missing image_file table. See comments in this migration file to fix this error" unless table_exists? :image_file

    # this loads images from the c
    old = OldImage.all
    old.each_with_index do |o, i|
      Image.create(id: o.id, image_bytes: o.image_bytes, width: o.width, height: o.height)
      puts "Saved #{i + 1} of #{old.size} Images"
    end
  end

  def down
    Image.delete_all
  end
end
