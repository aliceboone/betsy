require "faker"
require "date"
require "csv"

CSV.open("db/merchants_seeds.csv", "w", :write_headers => true, :headers => ["username", "email", "name"]) do |csv|
  25.times do
    username = Faker::FunnyName.two_word_name
    email = Faker::Internet.email
    name = Faker::Company.name
    # mailing_address = Faker::Address.full_address
    # credit_last_four = Faker::Number.number(digits: 4) #Faker::Number.number(4).uniq #=> "1968353479"
    # credit_expire = rand(Date.today.year..Date.today.year + 15)

    csv << [username, email, name]  # mailing_address, credit_last_four, credit_expire
  end
end


CSV.open("db/orders_seeds.csv", "w", :write_headers => true, :headers => ["status", "email", "address", "credit_name", "credit_expire", "security_code", "zip"]) do |csv|
  status_array = %w[pending paid shipped cancelled]
  15.times do
    status = status_array.sample
    email = Faker::Internet.email
    address = Faker::Address.full_address
    credit_name = Faker::FunnyName.two_word_name
    credit_expire = rand(Date.today.year..Date.today.year + 15)
    security_code = Faker::Number.number(digits: 3)
    zip = Faker::Address.zip

    csv << [status, email, address, credit_name, credit_expire, security_code, zip]
  end
end

CSV.open("db/products_seeds.csv", "w", :write_headers => true, :headers => %w[name description inventory price category photo rating]) do |csv|
  25.times do
    name = Faker::Commerce.product_name
    description = Faker::Lorem.sentence
    inventory = rand(0..25)
    price = Faker::Commerce.price(range: 0..200.0, as_string: false)
    category = "Other"
    photo = Faker::Placeholdit.image
    rating = rand(0...5)

    csv << [name, description, inventory, price, category, photo, rating]
  end
end


CSV.open("db/categories_seeds.csv", "w", :write_headers => true, :headers => %w[category_name]) do |csv|
  10.times do
    category_name = Faker::Color.color_name

    csv << [category_name]
  end
end