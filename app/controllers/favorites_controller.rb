class FavoritesController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save
    #redirect_back
    if params[:number_favorite] == "1"
      redirect_to book_path(book)
    elsif params[:number_favorite] == "2"
      redirect_to books_path
    end
  end
  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    #redirect_back
    #redirect_to book_path(book)
    if params[:number_favorite] == "1"
      redirect_to book_path(book)
    elsif params[:number_favorite] == "2"
      redirect_to books_path
    end
  end
end
