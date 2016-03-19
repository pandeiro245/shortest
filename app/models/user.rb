class User < ActiveRecord::Base
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
    @client = ::Twitter::REST::Client.new do |config|
      config.consumer_key    = ENV['TWITTER_KEY']
      config.consumer_secret = ENV['TWITTER_SECRET']
      config.access_token    = self.twitter_token
      config.access_token_secret = self.twitter_secret
    end
    #@client.user_timeline("pandeiro245")
    @client.home_timeline
    #@client.search("kintone", result_type: "recent", lang: "ja")
  end
end

