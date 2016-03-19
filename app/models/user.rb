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

  def tweets
    Tweet.order('id desc').limit(30)
  end

  def sync_home
    Tweet.sync_home(self)
  end

  def self.actives
    User.where.not(twitter_token: nil)
  end
end

