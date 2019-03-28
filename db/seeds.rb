
#User

User.create!(name:  "admin",
             email: "admin@gmail.com",
             password:              "123456",
             password_confirmation: "123456",
             role: 1)

50.times do |n|
  name  = Faker::Name.name
  email = "user-#{n+1}@gmail.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               role: 2)
end

#Author
50.times do |n|
  name  = Faker::Name.name
  email = "author-#{n+1}@gmail.com"
  password = "password"
  Author.create!(name:  name,
               email: email,
               info: "decribe-yourself")
end

#Books
authors = Author.all
authors.each do |author|
	name = Faker::Book.title
	quantity = 1000
	author.books.create!(name: name, quantity: quantity)
end

#Category
categories = ["textbook","novel", "manga","history", "scientist", "politic", "cultural", "computer", "technical", "geography"]
categories.each do |category|
	Category.create!(name: category)
end

#Bookcategory

# books = Book.all
# books.each do |book|
#   Bookcategory.create!(book_id: book.id ,category_id: Category.all[rand(10)].id )
# end
# Bookcategory.create!(book_id: 1 ,category_id: 9 )

# Category.all.each do |category|
#   Bookcategory.create!(book_id: Book.all[rand(50)].id ,category_id: category.id)
# end
