class RequestsController < ApplicationController

	# before_action :find_book, only: [:new, :create]
	before_action :find_user, only: [:new, :create]
	before_action :find_book, only: [:new, :create]
	before_action :find_request, only: [:destroy]
	def new
		@request = Request.new
	end

	def create
		# @request= Request.new(request_detail_params)
		@request= Request.new

		if @user.carts.last && @user.carts.last.verify == 3
			@request.cart_id = @user.carts.last.id
		else
			@request.cart_id = (@user.carts.create).id
		end
		@request.book_id = @book.id
		if @request.save
			# redirect_to books_url
			# flash[:success] = "Added to cart"
			respond_to do |format|
			    format.html
		    	format.js
		    	format.json{render json: @request}
		    end
		    # get_rq_json
		else
			# respond_to do |format|
			#     format.html
		 #    	format.js
		 #    end
		end

	end

	def destroy
		if @request.destroy
			redirect_to my_cart_cart_path
		else
		 	redirect_to my_cart_cart_path
		end
	end

	# get object append vao cart
	def get_rq_json
		request = Request.last
		respond_to do |format|
		    	format.json{render json: request}
		end
	end
	
	private
		def find_book
			@book = Book.find(params[:book_id])
		end

		def find_user
			@user = current_user
		end

		def find_cart
			@cart = Cart.find(@request.cart.id)
		end

		def find_request
			@request = Request.find(params[:id])
		end
end
