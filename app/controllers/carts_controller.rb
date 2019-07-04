class CartsController < ApplicationController
	# before_action :set_user
	before_action :find_user
	# before_action :find_book, only: [:new, :create, :show]
	# before_action :find_cart, only: [:destroy]
	# before_action :find_request, only: [:destroy]
	# before_action :find_user_cart, only: [:update_request_params,:accept,:decline,:confirm, :update_quantity,:show]
	before_action :find_detail_cart, only: [:detail]
	before_action :cart_and_request, only:[:show,:confirm,:update_request_params]


	def index
		@carts = Cart.carts_admin.order("created_at DESC")
	end

	def show
		@requests = @list_requests 	
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

	# def get_request_params dateto, number
	# 	dateto = params["dateto"] # get dateto tu tren view ve 
	# 	number = params["number"] # get number tu tren view ve
	# 	update_request_params(dateto,number)

	# end

	def update_request_params dateto,number
		session[:dateto] = dateto
		session[:number] = number
		@list_requests.each_with_index do |r,dem|
			if dateto && number
				r.update_attributes(number: session[:number][dem].to_i,datefrom: Time.zone.now.to_date, dateto: session[:dateto][dem].to_date)
				book = Book.find(r.book_id)
				if book.quantity >= r.number
					book.update_attributes(quantity: book.quantity - r.number)
				else
					render action: "show"
				end
			end	
		end

	end

	def confirm
		dateto = params["dateto"] # get dateto tu tren view ve 
		number = params["number"] # get number tu tren view ve
		update_request_params dateto, number
		@cart.update_attributes(verify: 0)
		if @cart.save
			redirect_to "/my_cart/" + current_user.id.to_s
		else
			render action: "show"
		end
			# RequestMailer.borrow_email(current_user,@request).deliver
			# flash[:success] = "Your request have been send to admin, please wait progess"
	end

	def accept 
	    @cart.verify = 1
	    if @cart.save
	    	# RequestMailer.reply_email(@request).deliver
	    	# flash[:success] = "Accept request"
	    	redirect_to carts_url
	    else
	    	# render action: "index"
		end
  	end

  	

  	def decline
	    	undo_quantity
	    	# RequestMailer.reply_email(@request).deliver
	    	# flash[:danger] = "Decline request"
  	end	

  	def update_request
  		
  	end

  	def destroy
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

		# def find_cart
		# 	@cart = Cart.where(user_id: @user.id).last
		# end

		def find_user_cart
			@cart = Cart.find(params[:id])
		end

		def find_detail_cart
			@cart_detail = Cart.find(params[:id])
		end

		def find_request
			@requests = Request.where(cart_id: @cart.id)
		end

		def cart_and_request
			@cart = Cart.find(params["id"])
			@list_requests = Request.where("cart_id = "+@cart.id.to_s)
		end

		def request_params
			params.require(:request).permit(:number,:dateto)
		end

		# def update_quantity list_requests
		# 	list_requests.each do |r|
		# 		@b = Book.find_by(id: r.book_id)
		# 		if r && r.number <= @b.quantity
		# 			@b.update_attributes(quantity: @b.quantity  - r.number)					
		# 			r = nil
		# 		else
		# 			flash[:danger] = "Khong du so luong"
		# 			render action: "show"
		# 		end
		# 	end
		# 	# if @cart.save
		# 		redirect_to root_url
		# 	# else
		# 		# render action: "show"
		# 	# end		s
		# end

		def undo_quantity
		 	@requests = Request.where("cart_id = "+ @cart.id.to_s)
			@requests.each do |r|
				@cart.verify = 2
				@book = Book.find(r.book_id)
				@book.quantity += r.number
				@book.save
	    		if @cart.save
  					redirect_to carts_url
	    		else
	    			redirect_to carts_url	
	    		end
			end
		end 
end
