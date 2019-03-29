class Book < ApplicationRecord

	belongs_to :author
	#ManytoMany Book_Category
	has_many :bookcategories, dependent: :destroy
	has_many :categories_book, through: :bookcategories	, source: :category
 	#ManytoMany Book_Liked_User
    has_many :likes, dependent: :destroy
	#ManytoMany Book_Rated_User
	has_many :rates, dependent: :destroy
	#ManytoMany Book_Commented_User
	has_many :comments, dependent: :destroy
	validates :name, presence: true, length: { maximum: 50 }
	validates :quantity, presence: true, length: { maximum: 1000 }

end
