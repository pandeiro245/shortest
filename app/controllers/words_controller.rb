class WordsController < ApplicationController
  def show
    Tweet.sync_word nil, params[:id]
    @word = Word.find_or_create_by(
      title: params[:id]
    )
  end
end
