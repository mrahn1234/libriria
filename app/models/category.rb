class Category < ApplicationRecord

	has_many :cb_bookcategories, class_name:  "Bookcategory",
                                  foreign_key: "category_id",
                                  dependent:   :destroy
	has_many :book_arr, :through => :cb_bookcategories, source: :book
	validates :name, presence: true, length: { maximum: 50 }
	
end
