class AddFavoteAndRetweetedToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :favorite_count, :integer
    add_column :tweets, :retweet_count, :integer
  end
end
