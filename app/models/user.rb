class User < ActiveRecord::Base
  attr_accessor :client
  #has_many :tweets, class_name: 'Tweet', foreign_key: 'twitter_id' 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def email_required?
    false
  end

  def password_required?
    false
  end

  def home
    Tweet.order('id desc').limit(30)
  end

  def tweets
    Tweet.where(twitter_id: twitter_id).order('id desc').limit(30)
  end

  def sync_home
    Tweet.sync_home(self)
  end

  def self.actives
    User.where.not(twitter_token: nil)
  end

  def self.sync_twitter_screen_name
    User.where(twitter_screen_name: nil).each do |user|
      user.twitter_screen_name = Tweet.client.user_timeline(user.twitter_id).first.user.screen_name
      user.save!
    end
  end

  def self.sync_twitter_profile_image_url
    User.where(twitter_profile_image_url: nil).each do |user|
      user.twitter_profile_image_url = Tweet.client.user_timeline(user.twitter_id).first.user.profile_image_url
      user.save!
    end
  end
end

