class Category < ApplicationRecord

	#ManytoMany Book_Category
	has_many :bookcategories, dependent: :destroy
	has_many :bookofcategory, through: :bookcategories	, source: :book
	#Validate
	validates :name, presence: true, length: { maximum: 50 }
	
end
