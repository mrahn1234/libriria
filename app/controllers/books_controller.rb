class BooksController < ApplicationController
	before_action :find_book, only: [:show, :edit, :update, :destroy, :categories_book]

	def index
		@q = Book.ransack(params[:q])
    	@books = @q.result.order("created_at DESC").page(params[:page])
    	@full_books = @q.result
    	respond_to do |format|
	      format.html
	      format.xls{send_data @full_books.to_csv(col_sep: "\t")}
    	end
	end

	
	def show
		@reviews = Review.where(book_id: @book_id).order("created_at DESC")	
		if @reviews.blank?
			@book.point = 0
		else
			@book.point = @book.reviews.average(:rating).round(2)
		end
	end

	def edit; end

	def update
		if @book.update(book_params)
			redirect_to book_path
		else
			render 'edit'
		end
	end
	
	def new
		@book= Book.new
		@book.bookcategories.build
	end

	def create
		@book= Book.new(book_params)
		if @book.save
			redirect_to @book
			flash[:success] = "Create book success"
		else
			render 'new'
			flash[:danger] = "Creating book failed"
		end
	end


	def destroy
		return unless @book.destroy
		redirect_to books_url
		flash[:success] = "Deleted book success"
	end

	private

	def book_params
		params.require(:book).permit(:name, :quantity, :publisher, 
			:page, :author_id, :book_img,  
			bookcategories_attributes: [:book_id,:category_id,:_destroy])	
	end

	def find_book
		@book = Book.find(params[:id])
	end


end
