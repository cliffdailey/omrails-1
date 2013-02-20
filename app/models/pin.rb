require 'open-uri'
require 'timeout'
class Pin < ActiveRecord::Base
	attr_accessor :image_url
	attr_accessible :description, :image, :image_url

	has_attached_file :image, :storage => :s3, :s3_credentials => S3_CREDENTIALS, styles: { large: '600x400>', medium: '320x240>', thumb: '100x100>'}

	before_validation :download_remote_image, :if => lambda { |pin| pin.image_url.present? }  
  
  validates :description, presence: true
  validates :user_id, presence: true
  validates_attachment :image, presence: true, content_type: { content_type: [ 'image/jpeg', 'image/jpg', 'image/png', 'image,gif', 'image/JPG']},
  											size: { less_than: 5.megabytes }, :if => Proc.new{|pin| pin.errors.empty?}

  belongs_to :user
  
  
  private  

  def download_remote_image
    return if self.image.present? 
    new_url = self.image_url.gsub(/https?:\/\//, "")   
    begin
      Timeout::timeout(5) do
        
        io = open URI.parse("http://" + new_url)
        def io.original_filename
          base_uri.path.split('/').last.scan(/([\w\.]*\.(?:png|jpe?g|gif|bmp|JPG|JPEG|BMP|GIF|PNG))/).flatten.first
        end
        self.image = io.original_filename.blank? ? nil : io
      end
    rescue Exception => e
      Rails.logger.error "Failed to download image from \"#{image_url}\": #{e.message}"
      errors.add(:image_url, "There was an error downloading the image. Check the URL.")
    end
  end
end
