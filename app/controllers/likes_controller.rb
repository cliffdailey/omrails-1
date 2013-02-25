class LikesController < ApplicationController
	def create 
		@pin = Pin.find(params[:pin_id])
		@like = current_user.likes.build(:pin_id => params[:pin_id])
		if @like.save
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
