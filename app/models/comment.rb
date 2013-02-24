class Comment < ActiveRecord::Base
  attr_accessible :content, :pin_id, :user_id
  validates :content, presence: true

  belongs_to :pin
  belongs_to :user
end
