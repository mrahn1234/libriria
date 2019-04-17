class CartsController < ApplicationController

	before_action :find_user, only: [:index, :show]
	before_action :check_cart, only: [:index, :show]

	def show
		@request_details = current_request.request_details
	end

	def index
		return unless @request
		@request_details = RequestDetail.where(request_id: @request.id).order("created_at DESC")	
		@books = Book.where(id: @request_details.ids)
	end

	private
		def find_user
			@user = current_user
		end

		def check_cart
			@request = @user.requests.last
		end
end
