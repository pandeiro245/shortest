class Word < ActiveRecord::Base
  def tweets
    Tweet.where("text like ?", "%#{title}%")
  end
end
