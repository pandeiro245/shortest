class WordsController < ApplicationController
  def index
    render json: Word.select(:title).pluck(:title)
  end

  def show
    Tweet.sync_word nil, params[:id]
    @word = Word.find_or_create_by(
      title: params[:id]
    )
  end
end
