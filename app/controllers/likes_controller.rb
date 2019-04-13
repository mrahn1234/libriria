class LikesController < ApplicationController
	def create
    @book = Book.find(params[:book_id])
    current_user.like_book(@book)
    redirect_to @book
  end

  def destroy
    @book = Like.find(params[:id]).book
    current_user.unlike_book(@book)
    redirect_to @book
  end
end
