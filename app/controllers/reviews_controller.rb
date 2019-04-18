class ReviewsController < ApplicationController
	before_action :set_review, only: [:show, :edit, :update, :destroy]
  # before_action :set_book
  before_action :logged_in_user

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    @user = User.find_by(id: @user_id )
  end

  # GET /reviews/new
  def new
    user = session[:user_id]
    # @review = Review.new
    @review = Review.new(book_id: params[:book_id])
    @book = Book.find(params[:book_id])
  end

  # GET /reviews/1/edit
  def edit
    @review = Review.find(params[:id])
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    # @review.user_id = current_user.id
    @review.user_id = session[:user_id]
    
    # @review.book_id = @book.id
    @book = Book.find(@review.book_id)
      if @review.save
          redirect_to @book    
      else
        # render 'new'
         redirect_to @book
      end 
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    if @review.update_attributes(review_params)
      @book  = Book.find(@review.book_id)
     @user = User.find(@review.user_id)
  
    flash[:success] = "Comment updated"
    redirect_to @book
    else 
      render "edit"
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    @book  = Book.find(@review.book_id)
    redirect_to @book
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    def set_book
      @book = Book.find(params[:id])
      # @book = Book.find(@review.book_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:rating, :comment, :user_id , :book_id)
    end
end
