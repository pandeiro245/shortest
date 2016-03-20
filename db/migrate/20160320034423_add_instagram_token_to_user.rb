class AddInstagramTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :instagram_id, :integer
    add_column :users, :instagram_token, :string
    add_column :users, :instagram_image, :string
    add_column :users, :instagram_nickname, :string
  end
end
