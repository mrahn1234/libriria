module RequestDetailsHelper
	def get_books_borrow id 
		count = 0
		request_details = RequestDetail.where(request_id: id)
		request_details.each do |rq|
			count += rq.number.to_i
		end
		return count
	end
end
