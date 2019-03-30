class Request < ApplicationRecord

	belongs_to :user
	belongs_to :book	
	has_many :bills
	
end
