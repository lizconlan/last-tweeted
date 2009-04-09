class TwittererController < ApplicationController
  
  def index
  end
  
  def show
    screen_name = params[:screen_name]
    @twitterer = Twitterer.new(screen_name)
  end
end
