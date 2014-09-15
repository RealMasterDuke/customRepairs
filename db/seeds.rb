# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

category = Category.create(title: 'Products')
Product.create(title: 'Example Product 1', text: 'Example Product Description 1', price: 1.00, category_id: 1)
Product.create(title: 'Example Product 2', text: 'Example Product Description 2', price: 2.00, category_id: 1)

