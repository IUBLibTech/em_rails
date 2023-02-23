class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def show
    @book = Book.includes(:annotations).find(params[:id])
  end

  def iu_url
    IU_URL
  end

  def temple_url
    TEMPLE_URL
  end

end
