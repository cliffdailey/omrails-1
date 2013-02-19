require 'open-uri'
require 'timeout'
class Pin < ActiveRecord::Base
	attr_accessor :image_url
	attr_accessible :description, :image, :image_url

	has_attached_file :image, :storage => :s3, :s3_credentials => S3_CREDENTIALS, styles: { large: '600x400>', medium: '320x240>', thumb: '100x100>'}

	before_validation :download_remote_image, :if => lambda { |pin| pin.image_url.present? }
  
  validates :description, presence: true
  validates :user_id, presence: true
  validates_attachment :image, presence: true, content_type: { content_type: [ 'image/jpeg', 'image/jpg', 'image/png', 'image,gif']},
  											size: { less_than: 5.megabytes }

  belongs_to :user
  
  
  private
  def download_remote_image
    return if self.image.present?
    begin
      Timeout::timeout(2) do
        io = open URI.parse(image_url)
        def io.original_filename
          base_uri.path.split('/').last.scan(/([\w\.]*\.(?:png|jpe?g|gif|bmp))/).flatten.first
        end
        self.image = io.original_filename.blank? ? nil : io
      end
    rescue Exception => e
      Rails.logger.error "Failed to download image from \"#{image_url}\": #{e.message}"
    end
  end
end
