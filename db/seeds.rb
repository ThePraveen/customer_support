# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.create!(:name => :customer)
Role.create!(:name => :executive)
Role.create!(:name => :admin)

new_admin = User.create!(:email => "admin@awign.com", :password => "11111111", :name => "Admin User")
new_admin.add_roles(['admin'])


IssueType.create!(:name => "Complaint")
IssueType.create!(:name => "Enquiry")
IssueType.create!(:name => "Contact")
IssueType.create!(:name => "Warning")

Permission.create(:name => "CAN_UPDATE_USER")
Permission.create(:name => "CAN_DELETE_USER")
Permission.create(:name => "CAN_UPDATE_CUSTOMER")
