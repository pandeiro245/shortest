class User < ActiveRecord::Base
  attr_accessor :client
  #has_many :tweets, class_name: 'Tweet', foreign_key: 'twitter_id' 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :random, -> {
    order("RAND()")
  }

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

  def recover_from_tweet
    Tweet.group(:twieet_id).each do |twitter_id, count|
      user = User.find_or_create_by(
        email: "tw-#{twitter_id}@245cloud.com",
        twitter_id: twitter_id,
      )
    end
  end

  def self.ts twitter_screen_name
    user = User.find_or_create_by(twitter_screen_name: twitter_screen_name)
    %w(id profile_image_url).each do |key|
      next if user.send("twitter_#{key}")
      key2 = key == 'id' ? user.twitter_screen_name : user.twitter_id
      begin
        user.send("twitter_#{key}=", Tweet.client.user_timeline(key2).first.user.send(key) )
      rescue

      end
      user.save!
    end
    user
  end

  def sync
    key2 = key == 'id' ? self.twitter_screen_name : self.twitter_id
    self.send("twitter_#{key}=", Tweet.client.user_timeline(key2).first.user.send(key) )
    self.save!
  end

  def self.sync
    %w(id screen_name profile_image_url).each do |key|
      User.where("twitter_#{key}" => nil).each do |user|
        user.sync
      end
    end
    sleep 60 * 10
    self.sync
  end
end

