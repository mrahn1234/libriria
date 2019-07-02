class CartsController < ApplicationController
	# before_action :set_user
	before_action :find_user
	# before_action :find_book, only: [:new, :create, :show]
	before_action :find_cart, only: [:show,:destroy, :confirm,:get_request_params,:update_request_params]
	before_action :find_request, only: [:destroy]
	before_action :find_user_cart, only: [:accept,:decline]
	before_action :find_detail_cart, only: [:detail]


	def index
		@carts = Cart.carts_admin.order("created_at DESC")
	end

	def show
		@requests = @cart.requests if @cart.verify == 3
		respond_to do |format|
			    format.html
		    	format.js
		    	format.json{render json: @requests}
		end
	end

	def detail
		@requests_detail = Request.where(cart_id: @cart_detail.id)
	end

	def my_cart
		return @carts = Cart.where("verify not like '3' and user_id"+"= "+ @user.id.to_s).order("created_at DESC") if user_signed_in?
	end

	def get_request_params
		dateto = params["dateto"] # get dateto tu tren view ve 
		number = params["number"] # get number tu tren view ve
		update_request_params(dateto,number)	
		confirm
		
	end

	def update_request_params dateto_arr,number_arr
		@requests = Request.where(cart_id: @cart.id)
		i = 0
		@requests.each do |r|
			r.update_attributes(number: number_arr[i],datefrom: Time.zone.now.to_date, dateto: dateto_arr[i])
			i = i+1
		end
	end

	def confirm 
		@cart.verify = 0
		if @cart.save
	    	update_quantity	    	
			# RequestMailer.borrow_email(current_user,@request).deliver
			# flash[:success] = "Your request have been send to admin, please wait progess"
			redirect_to my_cart_cart_path
		else
			flash[:danger] = "Your request can't be confirmed"
		end
	end

	def accept 
	    @cart.verify = 1
	    byebug
	    if @cart.save
	    	# RequestMailer.reply_email(@request).deliver
	    	# flash[:success] = "Accept request"
	    	redirect_to carts_url
	    else
	    	render action: "index"
	end
  	end

  	

  	def decline
	    @cart.verify = 2
	    if @cart.save
	    	undo_quantity
	    	redirect_to carts_url
	    	# RequestMailer.reply_email(@request).deliver
	    	# flash[:danger] = "Decline request"
	    else
  			redirect_to carts_url
	    end
  	end	

  	def update_request
  		
  	end

  	def destroy
  		byebug
  		# if @user.role == 1
  		# 	if @cart.verify == 3
  		# 		undo_quantity
  		# 		if @cart.destroy
  		# 			redirect_to carts_url
  		# 		else
	   #  			redirect_to carts_url
  		# 		end
  		# 	end
  		# else
  		# 	if @cart.verify == 3
  		# 		undo_quantity
  		# 	end
	   #  		redirect_to carts_url
  		# 	else
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
			@cart = Cart.where(user_id: @user.id).last
		end

		def find_user_cart
			@cart = Cart.find(params[:id])
		end

		def find_detail_cart
			@cart_detail = Cart.find(params[:id])
		end

		def find_request
			@requests = Request.where(cart_id: @cart.id)
		end

		def request_params
			params.require(:request).permit(:number,:dateto)
		end

		def update_quantity
			@requests = Request.where(cart_id: @cart.id)
			@requests.each do |r|
				@book = Book.find(r.book_id)
				@book.quantity -= r.number 
				@book.save
			end		
		end

		def undo_quantity
		 	@requests = Request.where(cart_id: @cart.id)
			@requests.each do |r|
				@book = Book.find(r.book_id)
				@book.quantity += r.number
				@book.save
			end
		end 
end
