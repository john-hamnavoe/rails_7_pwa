# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create!(name: "Scheduler", admin: true) unless User.find_by(name: "Scheduler")
User.create!(name: "Driver A", admin: false) unless User.find_by(name: "Driver A")
User.create!(name: "Driver B", admin: false) unless User.find_by(name: "Driver B")