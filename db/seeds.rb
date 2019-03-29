
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

Category
categories = ["textbook","novel", "manga","history", "scientist", "politic", "cultural", "computer", "technical", "geography"]
categories.each do |category|
	Category.create!(name: category)
end

#Bookcategory

books = Book.all
books.each do |book|
  book.categories_book  << Category.all[rand(10)]
end

#LikeBookUser
users= User.all

users.each do |user|
  user.liked_books << Book.all[rand(Book.all.count)]
end

#RateBookUser
users.each do |user|
    point = rand(1..5)
    book = Book.all[rand(Book.all.count)]
    Rate.create!(point: point, user_id: user.id, book_id: book.id)
end
users.each do |user|
   content = Faker::Quotes::Shakespeare.as_you_like_it_quote 
   book = Book.all[rand(Book.all.count)]
   Comment.create!(content: content, user_id: user.id, book_id: book.id)
end
