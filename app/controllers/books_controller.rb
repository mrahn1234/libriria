class BooksController < ApplicationController
	before_action :find_book, only: [:show, :edit, :update, :destroy, :categories_book]
	helper_method :sort_direction
	def index
    	@categories = Category.all
		@authors = Author.all
    	@pagy, @books = pagy_countless(Book.all.order("created_at DESC"), items: 9)
    	@sort = ["Default","Name of Book", "Name of Author"]
   
    		if params[:sort] === "Name of Book"
    			@pagy, @books = pagy_countless(Book.all.order(:sort), items: 9)
    		elsif params[:sort] === "Name of Author"
    			@pagy, @books = pagy_countless(Book.all.order(:sort), items: 9)
    		else
    			@pagy, @books = pagy_countless(Book.all.order("created_at DESC"), items: 9)
    		end
    		 @q = Book.ransack(params[:q])
    	respond_to do |format|
	      format.html
	      format.js
	      # format.xls{send_data @full_books.to_csv(col_sep: "\t")}
    	end
    	# byebug
	end

	
	def show
		@categories = Category.all
		@authors = Author.all
		# @reviews = Review.where(book_id: @book_id).order("created_at DESC")	
		if @reviews.blank?
			@book.point = 0
		else
			@book.point = @book.reviews.average(:rating).round(2)
		end
		respond_to do |format|
	      format.html
	      format.js
	      # format.xls{send_data @full_books.to_csv(col_sep: "\t")}
    	end
	end

	def edit; end

	def update
		if @book.update(book_params)
			flash[:success] = "Updating success"
			redirect_to book_path
		else
			flash[:danger] = "Updated failed"
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
			flash[:success] = "Creating book success"
			redirect_to @book
		else
			flash[:danger] = "Creating book failed"
			render 'new'
		end
	end


	def destroy
		return unless @book.destroy
		redirect_to books_url
		flash[:success] = "Deleted book success"
	end

	def sortoption
		@pagy, @books = pagy_countless(Book.all.order(:name), items: 9)
	end
	# def followers
	# @book = Book.find(params[:book_id])
 #    @title = "Followers of book"
 #    @users = @book.followers
 #    render 'show_follow' 
 #    end

 #    def likes
	# @book = Book.find(params[:book_id])
 #    @title = "Likes of book"
 #    @users = @book.liked_users
    
 #    render 'show_follow' 
 #    end
    
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
