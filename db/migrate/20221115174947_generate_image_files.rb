class CreateImageFiles < ActiveRecord::Migration[6.1]
  LOCATION = "#{Rails.root}/app/javascript/images"
  def up
    all = Image.all
    all.each_with_index do |i, ind|
      File.open("#{LOCATION}/#{i.id}.jpg", 'wb') {|f| f.write(i.image_bytes)}
      puts "Wrote image #{ind + 1} of #{all.size} Images"
    end
  end
  def down

  end
end
