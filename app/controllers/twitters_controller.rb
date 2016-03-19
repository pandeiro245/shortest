class TwittersController < ApplicationController
  def show
    @user = User.find_or_create_by(
      twitter_screen_name: params[:id]
    )
    if @user.tweets.blank?
      Tweet.sync_user nil, params[:id]
      @user.reload
    end
  end
end
