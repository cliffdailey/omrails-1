class Like < ActiveRecord::Base
  attr_accessible :integer, :pin_id, :user_id
  belongs_to :user
	belongs_to :pin
end
