class TweetsController < ApplicationController
  def show
    @tweet = Tweet.sync_tweet nil, params[:id]
  end
end
