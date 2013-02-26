class LikesController < ApplicationController
	def index
		@likes = current_user.likes.map { |like| like.pin_id }
		@pins = @likes.map { |pin| Pin.find(pin) }
	end
	def create 
		@pin = Pin.find(params[:pin_id])
		@like = current_user.likes.build(:pin_id => params[:pin_id])
		if !@pin.liking_users.include? current_user && @like.save
			respond_to do |format|
	      format.html { redirect_to root_url }
    	end
		else
			flash[:alert] = "Unable to like pin."
			redirect_to root_url
		end
	end
	def destroy
		@like = Like.find(params[:id])
		@like.destroy
		redirect_to root_url
	end
end
