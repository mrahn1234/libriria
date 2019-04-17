class RequestDetailsController < ApplicationController

	before_action :find_book, only: [:new, :create]
	before_action :find_user, only: [:new, :create,]
	before_action :find_request_detail, only: [:show, :destroy]
	before_action :find_request, only: [:update_quantity, :accept_request,:decline_request,:show,:destroy]
	#before_action :find_user, only: [:new, :create]

	def index
		@requests = Request.order("created_at DESC").page(params[:page])
	end

	def show
		@user = User.find(@request.user_id)
		@book = Book.find(@request.book_id)
	end


	def new
		@request_detail = RequestDetail.new
	end

	def create
		@request_detail = RequestDetail.new(request_detail_params)
		@request_detail.datefrom = Time.zone.now.to_date

		if @user.requests.last && @user.requests.last.verify == 3
			@request_detail.request_id = @user.requests.last.id
		else
			@request_detail.request_id = @user.requests.create.id
		end
		if @request_detail.save
			redirect_to books_url
		else
			render "new"
		end

	end

	def destroy
		if current_user.role == 2 
			redirect_to carts_url if @request_detail.destroy
		else
			redirect_to cart_request_path(@request) if @request_detail.destroy
		end
	end
	
	private
		def find_book
			@book = Book.find(params[:book_id])
		end

		def find_user
			@user = current_user
		end

		def find_request
			@request = Request.find(@request_detail.request.id)
		end

		def find_request_detail
			@request_detail = RequestDetail.find(params[:id])
		end

		def request_detail_params
			params.require(:request_detail).permit(:number,:dateto,:book_id).merge(book_id: params[:book_id])
		end

		def update_quantity
			# byebug
			@book = Book.find(@request.book_id)
			if @book.quantity >= @request.number
				@book.quantity -= @request.number
				@book.save
			end
			
		end
end
