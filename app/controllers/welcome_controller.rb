class WelcomeController < ApplicationController
  def index
    #@tweets = current_user.home if current_user
    if current_user
      begin
        @tweets = current_user.sync_home
      rescue
        @tweets = current_user.home
      end
    end
  end
end

