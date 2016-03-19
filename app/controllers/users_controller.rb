class UsersController < ApplicationController
  def login
    data = request.env['omniauth.auth']
    twitter_id = data['uid'].to_i
    user = User.find_by(
      twitter_id: twitter_id
    )
    if user.nil?
      user = User.new(
        email: "tw-#{twitter_id}@245cloud.com",
        twitter_id: twitter_id
      )
      user.twitter_token = data[:credentials][:token]
      user.twitter_secret = data[:credentials][:secret]
      user.save!
    end
    sign_in(user)
    redirect_to '/'
  end
end
