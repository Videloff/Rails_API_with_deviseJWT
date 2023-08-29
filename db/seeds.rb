# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

User.create(email: "oui@non.fr", password: "666666")

30.times do
  Article.create(
    title: Faker::Movie.title,
    content: Faker::Movie.quote,
    user_id: User.last.id
  )
end