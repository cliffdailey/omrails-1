module PinsHelper
	def user_like(pin_id)
		current_user.likes.find_by_pin_id(pin_id)
	end
end
