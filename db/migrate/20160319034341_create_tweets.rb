class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :twitter_id, limit: 8
      t.string :text
      t.string :text_escaped
      t.integer :in_reply_to_status_id, limit: 8
      t.boolean  "mecabed",             default: false

      t.timestamps null: false
    end
  end
end
