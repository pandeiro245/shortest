class WelcomeController < ApplicationController
  def index
    @tweets = current_user.home if current_user
  end
end

