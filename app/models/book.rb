class Book < ApplicationRecord

	belongs_to :author
	has_many :bc_bookcategories, class_name:  "Bookcategory",
                                  foreign_key: "book_id",
                                  dependent:   :destroy
	has_many :category_arr, :through => :bc_bookcategories, source: :category
	validates :name, presence: true, length: { maximum: 50 }
	validates :quantity, presence: true, length: { maximum: 1000 }

end
