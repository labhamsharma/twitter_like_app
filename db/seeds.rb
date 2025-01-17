# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# db/seeds.rb

# Create users
5.times do |i|
  User.create!(
    username: "user#{i + 1}",
    email: "user#{i + 1}@example.com",
    password: "password"
  )
end

# Create tweets for each user
User.all.each do |user|
  3.times do
    user.tweets.create!(
      content: "test content for checking the tweets"
    )
  end
end
