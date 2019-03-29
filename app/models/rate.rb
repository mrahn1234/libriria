class Rate < ApplicationRecord

	belongs_to :user
	belongs_to :book
	validates :user_id, presence: true
	validates :book_id, presence: true
	 validates :point, numericality: { only_integer: true, 
	 									less_than_or_equal_to: 5,
	 									greater_than_or_equal_to: 1}
	
end
