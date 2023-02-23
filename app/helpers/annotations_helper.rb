module AnnotationsHelper

  VIDEO = "#{Rails.root}/tmp/annotation_videos.json"
  AUDIO = "#{Rails.root}/tmp/annotation_audio.json"
  IMAGE = "#{Rails.root}/tmp/annotation_image.json"

  THUMBS = "#{Rails.root}/tmp/annotation_thumbs.json"

  def import_annotations
    Annotation.all.delete_all
    file = File.read(VIDEO)
    parse file

    file = File.read(AUDIO)
    parse file

    file = File.read(IMAGE)
    parse file
  end

  def import_thumbs
    file = File.read(THUMBS)
    data = JSON.parse(file)
    data.each_with_index do |a, i|
      an = Annotation.where(id: a['annotation_id'].to_i).first
      an.update(thumb_id: a['image'].to_i) unless an.nil?
      puts "Thumb #{i + 1} of #{data.size}"
    end
  end

  private
  def parse(file)
    data = JSON.parse(file)
    data.each_with_index do |a, i|
      Annotation.new(
        id: a["id"], book_id: a["book_id"], title: a["title"].html_safe, description: a["description"].html_safe, page_reference: a["page_reference"],
        sample: a["sample"] == "1" ? true : false, avalon_purl: a["avalon_purl"], media_type: a['media_type'], image_id: a["image_id"].to_i
        ).save!
      puts "Annotation #{i + 1} of #{data.size}"
    end
  end
end
