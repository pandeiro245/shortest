class WelcomeController < ApplicationController
  def index
    @tweets = current_user.home
  end
end

