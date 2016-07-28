# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
additional_data = ENV["MAILGUN_URL"] + '|' + ENV["MAILGUN_KEY"]
puts '-------------'
puts additional_data
Sender.create([{ :name => 'Mailgun', :active => true, :sender_class => 'Mailgun', :additional_data => additional_data}])
