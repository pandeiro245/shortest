class TwittersController < ApplicationController
  def show
    @user = User.find_or_create_by(
      twitter_screen_name: params[:id]
    )
    if params[:refresh] || @user.tweets.blank? || @user.tweets.count < 20
      Tweet.sync_user nil, params[:id]
      @user.reload
    end
  end
end
