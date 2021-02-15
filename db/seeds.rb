# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  name: "Admin User",
  email: "admin@example.com",
  password: "password",
  password_confirmation: "password",
  name_kana: "アドミン　ユーザー",
  postcode: "5300001",
  prefecture_code: 27,
  address_city: "大阪市北区梅田",
  address_street: "",
  address_building: "",
  is_valid: true,
  admin: true
)
