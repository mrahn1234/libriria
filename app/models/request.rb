class Request < ApplicationRecord

	belongs_to :user
	#belongs_to :book
	has_many :request_details, dependent: :destroy
		
	has_many :books, through: :request_details, source: :book
end
