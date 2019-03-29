class User < ApplicationRecord

	#ManytoMany User_Like_Book
	has_many :likes, dependent: :destroy
	has_many :liked_books, through: :likes, source: :book	
	#ManytoMany User_Rate_Book
	has_many :rates, dependent: :destroy
	has_many :rated_books, through: :rates, source: :book
	#ManytoMany User_Comment_Book
	has_many :comments, dependent: :destroy
	has_many :commented_books, through: :comments, source: :book
	#Validate
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true, length: { maximum: 50 }
  	validates :email, presence: true, length: { maximum: 255 },
					 format: { with: VALID_EMAIL_REGEX }, 
					 uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
	has_secure_password

end

