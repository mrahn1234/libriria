class RequestsController < ApplicationController

	before_action :find_book, only: [:new, :create]
	before_action :find_request, only: [:update_quantity, :accept_request,:decline_request,:show]
	#before_action :find_user, only: [:new, :create]

	def index
		@requests = Request.order("created_at DESC").page(params[:page])
	end

	def show
		@user = User.find(@request.user_id)
		@book = Book.find(@request.book_id)
	end


	def new
		@user = current_user
		@request = Request.new
		# byebug
	end

	def create
		@request= Request.new(request_params)
		@request.book_id = @book.id
		@request.user_id = current_user.id
		@request.datefrom  = Time.zone.now
		# @book.quantity -= @request.number
		# @book.save

		if @request.save
			redirect_to requests_url
		else
			render 'new' 
		end 
	end

	def accept_request
	    @request.verify = 1
	    if @request.save
	    	update_quantity
	    	flash[:sucess] = "Accept request"
	    end
	    redirect_to requests_url
  	end

  	def decline_request
	    @request.verify = 2
	    if @request.save
	    	flash[:danger] = "Decline request"
	    end
	    redirect_to requests_url
  	end

  	def return_book
  		
  	end
	private
		def find_book
			@book = Book.find(params[:book_id])
		end

		def find_user
			@user = User.find[params[:user_id]]
		end

		def find_request
			@request = Request.find(params[:id])
		end

		def request_params
			params.require(:request).permit(:number,:dateto)
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
