class Book < ApplicationRecord

	belongs_to :author
	#ManytoMany Book_Category
	has_many :bookcategories, dependent: :destroy
	has_many :categories, through: :bookcategories	#, source: :category
	accepts_nested_attributes_for :bookcategories, allow_destroy: true
 	#ManytoMany Book_Liked_User
    has_many :likes, dependent: :destroy
	#ManytoMany Book_Reviewed
	has_many :reviews, dependent: :destroy
	#ManytoMany Book_Requested_User
	has_many :requests, dependent: :destroy
	#Many to Many Poly Follow book, author
	has_many :follows, as: :target, dependent: :destroy

	validates :name, presence: true, length: { maximum: 50 }
	validates :quantity, presence: true, length: { maximum: 1000 }

end
