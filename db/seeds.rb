# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create(first_name: 'admin', last_name: 'admin', email: 'admin@admin.com', password:'123456')

d1 = Disaster.new(disaster_type: 'flood')
d1.avatar.attach(io: File.open('app/assets/images/flood-icon.png'), filename: 'flood-icon.png', content_type: 'image/png')
d1.save

d2 = Disaster.new(disaster_type: 'landslide')
d2.avatar.attach(io: File.open('app/assets/images/landslide-icon.png'), filename: 'landslide-icon.png', content_type: 'image/png')
d2.save

d3 = Disaster.new(disaster_type: 'tornado')
d3.avatar.attach(io: File.open('app/assets/images/tornado-icon.png'), filename: 'tornado-icon.png', content_type: 'image/png')
d3.save

d4 = Disaster.new(disaster_type: 'tsunami')
d4.avatar.attach(io: File.open('app/assets/images/tsunami-icon.png'), filename: 'tsunami-icon.png', content_type: 'image/png')
d4.save
