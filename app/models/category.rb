class Category < ApplicationRecord

	#ManytoMany Book_Category
	has_many :bookcategories, dependent: :destroy
	#Validate
	validates :name, presence: true, length: { maximum: 50 }
	
end
