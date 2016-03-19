class Tweet < ActiveRecord::Base
  attr_accessor :client
  #belongs_to :user, class_name: 'User', foreign_key: 'twitter_id'
  def user
    User.find_by(twitter_id: self.twitter_id)
  end

  def self.client user
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
    #self.client(user).user_timeline('pandeiro245').each do |tweet|
    self.client(user).home_timeline.each do |tweet|
      user = User.find_or_create_by(
        twitter_id: tweet.user.id,
        email: "tw-#{tweet.user.id}@245cloud.com"
      )
      puts user.inspect
      puts "tweet_id is #{tweet.id}"
      puts tweet.user.id

      user.twitter_profile_image_url = 
        tweet.user.profile_image_url.to_s

      user.save!
      tweet2 = Tweet.find_or_initialize_by(
        id: tweet.id,
      )
      puts tweet2.inspect
      tweet2.twitter_id = tweet.user.id
      tweet2.text = tweet.text
      tweet2.save!
    end
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

