class BooksController < ApplicationController
	before_action :find_book, only: [:show, :edit, :update, :destroy, :categories_book]

	def index
		@q = Book.ransack(params[:q])
    	@books = @q.result.order("created_at DESC").page(params[:page])
    	@full_books = @q.result
    	respond_to do |format|
	      format.html
	      format.xls{send_data @full_authors.to_csv(col_sep: "\t")}
	      format.js
    	end
	end

	
	def show;end

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
		byebug
		if @book.save
			#Bookcategory.create!(book_id: @book.id, category_id: params[:book][:categories])
			redirect_to @book
		else
			render 'new'
		end
	end


	def destroy
		@book.destroy
		respond_to do |format|
	      format.js
    	end
	end

	private

	def book_params
		params.require(:book).permit(:name, :quantity, :publisher, 
			:page, :author_id,  
			:bookcategories_attributes =>[:category_id,:_destroy])	
	end

	def find_book
		@book = Book.find(params[:id])
	end


end
