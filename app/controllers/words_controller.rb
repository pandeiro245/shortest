class WordsController < ApplicationController
  def show
    @word = Word.find_or_create_by(
      title: params[:id]
    )
  end
end
