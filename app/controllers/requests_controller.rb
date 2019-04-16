class RequestsController < ApplicationController


	before_action :find_request, only: [:update_quantity,:confirm_request,:cart,:accept_request,:decline_request,:show]
	# #before_action :find_user, only: [:new, :create]

		
	def index
		@q = Request.ransack(params[:q])
    	@requests = @q.result.order("created_at DESC").page(params[:page])
	end

	def confirm_request
		@request.verify = 0
		if @request.save
			RequestMailer.borrow_email(current_user,@request).deliver
			flash[:sucess] = "Your request have been send to admin, please wait progess"
			redirect_to root_url
		else
			flash[:danger] = "Your request can't be confirmed"
		end
	end

	def accept_request
	    @request.verify = 1
	    if @request.save
	    	RequestMailer.reply_email(@request).deliver
	    	update_quantity
	    	flash[:sucess] = "Accept request"
		end
	    redirect_to requests_url
  	end

  	def decline_request
	    @request.verify = 2
	    if @request.save
	    	RequestMailer.reply_email(@request).deliver
	    	flash[:danger] = "Decline request"
	    end
	    redirect_to requests_url
  	end

  	def cart
  		@request_details = RequestDetail.where(request_id: @request.id)	
  	end

  	private	

  		def find_request
  			@request = Request.find(params[:id])
  		end
		def update_quantity
			@requests_detail = RequestDetail.where(request_id: @request.id)
			@requests_detail.each do |request_detail|
				@book = Book.find(request_detail.book_id)
				if @book.quantity >= request_detail.number
					@book.quantity -= request_detail.number
					@book.save
				end
			end	
			
		end

end
