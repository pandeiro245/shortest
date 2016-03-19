class Tweet < ActiveRecord::Base
  attr_accessor :client
  belongs_to :user, class_name: 'User', foreign_key: 'twitter_id'
  def initialize user
    @client = ::Twitter::REST::Client.new do |config|
      config.consumer_key    = ENV['TWITTER_KEY']
      config.consumer_secret = ENV['TWITTER_SECRET']
      config.access_token    = user.twitter_token
      config.access_token_secret = user.twitter_secret
    end
    #@client.user_timeline("pandeiro245")
    #@client.search("kintone", result_type: "recent", lang: "ja")
  end

  def home
    @client.home_timeline.map do |tweet|
      user = User.find_or_create_by(
        twitter_id: tweet.user.id,

      )
      user.twitter_profile_image_url = 
        tweet.user.profile_image_url.to_s
      Tweet.find_or_create_by(
        id: tweet.id
      )
    end
  end
end

