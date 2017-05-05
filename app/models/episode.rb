class Episode < ActiveRecord::Base
  belongs_to :podcast
  
  is_impressionable

  has_attached_file :episode_thumbnail, styles: { medium: "500x500#", large: "1000x1000#" } 
  validates_attachment_content_type :episode_thumbnail, content_type: /\Aimage\/.*\z/
  
  has_attached_file :mp3
  validates_attachment :mp3,
    :content_type => { :content_type => ["audio/mpeg", "audio/mp3"] },
    :file_name => { :matches => [/mp3\Z/] }
end
