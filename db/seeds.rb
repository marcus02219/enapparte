# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

User.create(firstname:"asdasd",surname:"asdsad",gender:1, email:"gasdas@mail.ru" , password:"dfghjkllkiu7",phone_number:"+89276214346",provider:"fb",uid:123,dob:Time.now ,activity:"asdsad")
puts "1st test user created"
Address.create(street:"sdadasd",postcode:"12345",city:"Asdsa",state:"asdsad",country:"Masdaserd",latitude:41.1,longitude:42.21)
Booking.create(status:1,date:Time.now,spectators:123,price:123,message:"asdasd",payout:12.1,payment_received?:true,payment_sent?:false,paid_on:Time.now,paid_out_on:Time.now)
PaymentMethod.create(payoption:"cc",provider:"stripe")
Show.create(title:"asdasd",length:"123",description:"aasdasd",price:55.21,max_spectators:121,starts_at:Time.now,ends_at:Time.now,active:true)
Comment.create(content:"asdsadasdasd")
Art.create(title:"asdasdas",description:"asdasdasdasd")
Rating.create(value:5)
Picture.create(title:"asdas",url:"asdasa")
Language.create(title:"asdasdasd")
