class TwittersController < ApplicationController
  def show
    if params[:refresh]
      Tweet.sync_user nil, params[:id]
    end
    @user = User.find_or_create_by(
      twitter_screen_name: params[:id]
    )
  end
end
