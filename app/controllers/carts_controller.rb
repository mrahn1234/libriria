class CartsController < ApplicationController
	# before_action :set_user
	before_action :find_user
	# before_action :find_book, only: [:new, :create, :show]
	before_action :find_cart, only: [:show, :confirm,:get_request_params,:update_request_params]
	before_action :find_request, only: [:destroy]


	def index
		if @user.role === 1 
			@carts = Cart.carts_admin
		else
			@carts = Cart.where(user_id: current_user.id, verify: !3)
		end
	end



	def show
		@requests = @cart.requests if @cart.verify == 3
		respond_to do |format|
			    format.html
		    	format.js
		    	format.json{render json: @requests}
		end
	end

	def get_request_params
		dateto = params["dateto"] # get dateto tu tren view ve 
		number = params["number"] # get number tu tren view ve
		update_request_params(dateto,number)	
		
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
			redirect_to carts_url
		else
			flash[:danger] = "Your request can't be confirmed"
		end
	end

	def accept
	    @cart.verify = 1
	    if @cart.save
	    	# RequestMailer.reply_email(@request).deliver
	    	# flash[:success] = "Accept request"
		end
	    redirect_to carts_url
  	end

  	

  	def decline
	    @cart.verify = 2
	    if @cart.save
	    	undo_quantity
	    	# RequestMailer.reply_email(@request).deliver
	    	# flash[:danger] = "Decline request"
	    end
	    redirect_to carts_url
  	end	

  	def update_request
  		
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
