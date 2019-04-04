class User < ApplicationRecord

	#ManytoMany User_Like_Book
	has_many :likes, dependent: :destroy
	has_many :liked_books, through: :likes, source: :book	
	#ManytoMany User_Request_Book
	has_many :requests, dependent: :destroy
	has_many :requested_books, through: :requests, source: :book
	#ManytoMany User_Review_Book
	has_many :reviews, dependent: :destroy
	has_many :reviewed_books, through: :reviews, source: :book
	#Validate
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true, length: { maximum: 50 }
  	validates :email, presence: true, length: { maximum: 255 },
					 format: { with: VALID_EMAIL_REGEX }, 
					 uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
	has_secure_password

end

