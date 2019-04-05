class BooksController < ApplicationController
	before_action :find_book, only: [:show, :edit, :update, :destroy, :categories_book]

	def index
		@books = Book.all.order("created_at DESC")
	end

	def new
		@book= Book.new
	end

	def create
		#byebug
		@book= Book.new(book_params)
		#@book.categories_book << Category.find(params[:category][:category_id])
		# @book_category = Bookcategory.new(book_id: @book.id, category_id: @category.id)
		
		if @book.save
			
			redirect_to root_path
		else
			render 'new'
		end
	end

	def show
	end

	def edit
	end

	def update
		if @book.update(book_params)
			redirect_to book_path
		else
			render 'edit'
		end
	end

	def destroy
		@book.destroy
		redirect_to root_path
	end

	private

	def book_params
		params.require(:book).permit(:name,:quantity,:publisher,:page, :author_id, :categories_book_id)
	end

	def category_params
		params.require(:book).permit([:categories_book])
	end
	def find_book
		@book = Book.find(params[:id])
	end

end
