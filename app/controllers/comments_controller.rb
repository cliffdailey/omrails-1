class CommentsController < ApplicationController
  before_filter :authenticate_user! 

  def create
    pin = Pin.find(params[:pin_id])
    @comment = pin.comments.create!(params[:comment])
    redirect_to pin_path(pin)
  end
  
end
