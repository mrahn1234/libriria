class RequestsController < ApplicationController
	def new
		
	end

	def create
		@request= RequestDetail.new(request_detail_params)
		@request.datefrom = Time.zone.now.to_date

		if @user.carts.last && @user.carts.last.verify == 3
			@request.cart_id = @user.carts.last.id
		else
			@request.cart_id = (@user.carts.create).id
		end

		if @cart.save
			redirect_to books_url
			flash[:success] = "Added to cart"
		else
			render "new"
		end

	end

	def destroy
		# if current_user.role == 2 
		# 	redirect_to carts_url if @request.destroy
		# else
		# 	redirect_to cart_request_path(@request) if @request_detail.destroy
		# end
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
end
