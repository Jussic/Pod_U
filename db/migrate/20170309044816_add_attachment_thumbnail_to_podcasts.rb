class AddAttachmentThumbnailToPodcasts < ActiveRecord::Migration
  def self.up
    change_table :podcasts do |t|
      t.attachment :thumbnail
    end
  end

  def self.down
    remove_attachment :podcasts, :thumbnail
  end
  
  def post_params
  params.require(:post).permit(:date, :time, :subject, :format, :copy, image: [:image_file_name, :image_file_size, :image_content_type, :image_updated_at])
  end
  
end
