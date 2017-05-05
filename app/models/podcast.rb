class Podcast < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  is_impressionable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :episodes
  
  has_attached_file :thumbnail, styles: { medium: "500x500#", large: "1000x1000#" } 
  validates_attachment_content_type :thumbnail, content_type: /\Aimage\/.*\z/
  
  # PRODUCED ERRORS #
  # has_attached_file :thumbnail, styles: { thumb: "64x64", small: "100x100", medium: "550x550>", large: "1000x1000>" }
  # validates_attachment_content_type :thumbnail, :content_type => /\Aimage\/.*\z/
  # has_attached_file :thumbnail, styles: { :large => "1000x1000#>", :medium => "550x550#>" }
end
