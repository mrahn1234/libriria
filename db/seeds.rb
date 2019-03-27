
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

