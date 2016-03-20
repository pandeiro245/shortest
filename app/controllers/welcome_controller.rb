class WelcomeController < ApplicationController
  def index
    #@tweets = current_user.home if current_user
    @tweets = current_user.sync_home if current_user
  end
end

