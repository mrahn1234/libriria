class Request < ApplicationRecord

	belongs_to :user
	belongs_to :book
	#has_many :request_details, dependent: :destroy

end
