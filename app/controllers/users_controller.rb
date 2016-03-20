class UsersController < ApplicationController
  def login
    provider = params[:provider]
    data = request.env['omniauth.auth']

    id = data['uid'].to_i
    short = provider == 'twitter' ? 'tw' : 'ig'

    user = User.find_by(
      "#{provider}_id" => id
    )
    if user.nil?
      user = User.new(
        email: "#{short}-#{id}@245cloud.com",
        "#{provider}_id" =>  id
      )
    end


    if provider == 'twitter'
      user.twitter_token = data[:credentials][:token]
      user.twitter_secret = data[:credentials][:secret]
      user.twitter_profile_image_url = data[:profile_image_url]
      user.twitter_screen_name = data[:screen_name]
    else
      user.instagram_token = data[:credentials][:token]
      user.instagram_image = data[:info][:image]
      user.instagram_nickname = data[:info][:nickname]
    end
    user.save!
    sign_in(user)
    redirect_to '/'
  end
end
