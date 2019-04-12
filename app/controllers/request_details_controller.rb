class RequestDetailsController < ApplicationController
	def new
		@request_detail = RequestDetail.new
	end
end
