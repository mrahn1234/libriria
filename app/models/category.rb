class Category < ApplicationRecord

	has_many :bookcategories
	has_many :books, :through => :bookcategories
	validates :name, presence: true, length: { maximum: 50 }
	
end
