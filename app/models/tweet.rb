class Tweet < ActiveRecord::Base
  attr_accessor :client
  #belongs_to :user, class_name: 'User', foreign_key: 'twitter_id'
  def user
    User.find_by(twitter_id: self.twitter_id)
  end

  def self.client user = nil
    user ||= User.actives.first
    ::Twitter::REST::Client.new do |config|
      config.consumer_key    = ENV['TWITTER_KEY']
      config.consumer_secret = ENV['TWITTER_SECRET']
      config.access_token    = user.twitter_token
      config.access_token_secret = user.twitter_secret
    end
    #@client.user_timeline("pandeiro245")
    #@client.search("kintone", result_type: "recent", lang: "ja")
  end

  def self.sync_home user
    self.client(user).home_timeline.each do |tweet|
      self.import(tweet)
    end
  end

  def self.sync_user user, screen_name
    self.client(user).user_timeline(screen_name).each do |tweet|
      self.import(tweet)
    end
  end

  def self.import tweet
    user = User.find_or_create_by(
      twitter_id: tweet.user.id,
      email: "tw-#{tweet.user.id}@245cloud.com"
    )
    user.twitter_profile_image_url = 
      tweet.user.profile_image_url.to_s
    user.twitter_screen_name = tweet.user.screen_name

    user.save!
    tweet2 = Tweet.find_or_initialize_by(
      id: tweet.id,
    )
    tweet2.twitter_id = tweet.user.id
    tweet2.text = tweet.text
    tweet2.save!
  end

  def self.sync refresh=false
    if refresh
      Tweet.delete_all
      User.delete_all
    end
    User.actives.each do |user|
      user.sync_home
    end
    sleep 60
    self.sync
  end
end

