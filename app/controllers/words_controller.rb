class WordsController < ApplicationController
  def index
    if title = params[:title]
      redirect_to "/words/#{URI.encode(title)}"
    else
      render json: Word.select(:title).pluck(:title)
    end
  end

  def show
    #Tweet.sync_word nil, params[:id]
    @word = Word.find_or_create_by(
      title: params[:id]
    )
  end
end
