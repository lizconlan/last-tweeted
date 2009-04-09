class TwittererController < ApplicationController
  
  def show
    screen_name = params[:screen_name]
    @twitterer = Twitterer.new(screen_name)
  end
end
