# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Show.import force: true

User.destroy_all
Show.destroy_all
Address.destroy_all
Booking.destroy_all
Rating.destroy_all
Comment.destroy_all
Language.destroy_all
Picture.destroy_all
Art.destroy_all


user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

10.times do
  Language.create(title: Faker::Lorem.word)
  Art.create(
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph
  )
end

main_user = User.create(
  firstname: Faker::Name.first_name,
  surname: Faker::Name.last_name,
  gender: 1,
  email: 'csolg7@gmail.com',
  password: "dfghjkllkiu7",
  phone_number: "927-621-4346",
  provider: "fb",
  uid: 123,
  dob:Time.now,
  activity:"asdsad",
  language: Language.all.sample
)

main_user.confirm!

5.times.each do |i|
  Address.create(user: main_user,
                 street: Faker::Address.street_address,
                 postcode:Faker::Number.number(5),
                 city: Faker::Address.city,
                 state: Faker::Address.state,
                 country: Faker::Address.country,
                 latitude:41.1,
                 longitude:42.21
                )
end

# users
5.times.each do |i|
  user = User.create(
    gender: User.genders.keys.sample,
    firstname: Faker::Name.first_name,
    surname: Faker::Name.last_name,
    email: Faker::Internet.free_email,
    password: '123'*3,
    phone_number: Faker::Number.number(10).gsub(/(\d{3})(\d{3})(\d{4})/, '\1-\2-\3'),
    dob: Faker::Time.backward(14000, :evening).to_date,
    activity: Faker::Lorem.sentence,
    language: Language.first
  )
end

# Shows
User.all.each do |user|
  user.picture.image = File.open(Dir[Rails.root.join('spec/fixtures/photos/*')].sample)
  user.picture.save
  25.times.each do |i|
    show = Show.create(
      user: user,
      title: Faker::Lorem.word,
      length: Faker::Number.number(3),
      description: Faker::Lorem.sentence,
      price: Faker::Number.decimal(5,2),
      max_spectators: 10,
      starts_at: Faker::Time.between(Time.now, 14.days.from_now),
      ends_at: Faker::Time.between(15.days.from_now, 50.days.from_now),
      active: true,
      language: Language.all.sample,
      art: Art.all.sample,
    )

    pictures = 7.times.map do
      Picture.create(
        image: File.open(Dir[Rails.root.join('spec/fixtures/pictures/*')].sample),
        imageable: show
      )
    end
    show.cover_picture = pictures.first
    show.save
  end

  # PaymentMethod
  5.times.each do |i|
    PaymentMethod.create(
      user: user,
      payoption: Faker::Lorem.sentence,
      provider: Faker::Company.name
    )
  end
end

User.all.each do |user|
  4.times.each do |status|
    20.times.each do
      booking = Booking.create(
        user: user,
        show: Show.where('user_id != ?', user.id).all.sample,
        status: Faker::Number.between(1, 4),
        date: Faker::Time.between(1.days.ago, 10.days.from_now),
        spectators: Faker::Number.between(1, 10),
        price: Faker::Number.decimal(5,2),
        message: Faker::Lorem.sentence,
        payout: Faker::Number.decimal(5,2)
      )
      3.times.each do
        Rating.create(
          booking: booking,
          value: Faker::Number.between(1, 5)
        )
      end
      Comment.create(
        booking: booking,
        content: Faker::Lorem.sentence
      )
    end
  end
end


