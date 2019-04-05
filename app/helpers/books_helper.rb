module BooksHelper
	def get_authors id
		Author.order(id)
	end
	def get_categories id
		Category.order(id)
	end
end
