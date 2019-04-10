class Author < ApplicationRecord

	has_many :books, dependent: :destroy
	has_many :follows, as: :target, dependent: :destroy
		
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true, length: { maximum: 50 }
  	validates :email, presence: true, length: { maximum: 255 },
					 format: { with: VALID_EMAIL_REGEX }, 
					 uniqueness: { case_sensitive: false }
	

	def self.to_csv(option ={})
		CSV.generate(option) do |csv|
			csv << column_names
			all.each do |author|
				csv << author.attributes.values_at(*column_names)
			end
		end
	end
end
