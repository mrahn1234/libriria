class Comment < ApplicationRecord

	#Relationship
	belongs_to :user
	belongs_to :book

	#Validates
	validates :user_id, presence: true
	validates :book_id, presence: true
	validates :content, length: {maximum: 200}
end
