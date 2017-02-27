# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

customer_role = Role.create!(:name => :customer)
executive_role = Role.create!(:name => :executive)
admin_role = Role.create!(:name => :admin)

new_admin = User.create!(:email => "admin@awign.com", :password => "11111111", :name => "Admin User")
new_admin.add_roles(['admin'])