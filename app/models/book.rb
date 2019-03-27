class Book < ApplicationRecord

	belongs_to :author
	has_many :bookcatagories
	has_many :books, :through => :bookcategories
	validates :name, presence: true, length: { maximum: 50 }
	validates :quantity, presence: true, length: { maximum: 1000 }

end
