class User < ApplicationRecord

	attr_accessor :remember_token
	before_save { self.email = email.downcase }

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


	# Returns the hash digest of the given string.
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
													  BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	# returns a random token
	def User.new_token
		SecureRandom.urlsafe_base64
	end 

	#  remember a user in the database for use in persistent sessions
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	# return true if the given token matches the digest
	def authenticated?(remember_token)
		return false if remember_digest.nil?
		Bcrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	def forget
		update_attribute(remember_digest, nil)
	end

end

