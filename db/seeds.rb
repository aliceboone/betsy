require 'csv'

MERCHANT_FILE = Rails.root.join('db', 'merchants_seeds.csv')
puts "Loading raw work data from #{MERCHANT_FILE}"

merchant_failures = []
CSV.foreach(MERCHANT_FILE, :headers => true) do |row|
  merchant = Merchant.new
  merchant.id = row['id']
  merchant.username = row['username']
  merchant.email = row['email']
  merchant.mailing_address = row['mailing_address']
  merchant.credit_last_four = row['credit_last_four']
  merchant.credit_expire = row['credit_expire']
  successful = merchant.save
  if !successful
    merchant_failures << merchant
    puts "Failed to save work: #{merchant.inspect}"
  else
    puts "Created work: #{merchant.inspect}"
  end
end

puts "Added #{Merchant.count} merchant records"
puts "#{merchant_failures.length} merchant failed to save"


ORDER_FILE = Rails.root.join('db', 'orders_seeds.csv')
puts "Loading raw work data from #{ORDER_FILE}"

order_failures = []
CSV.foreach(ORDER_FILE, :headers => true) do |row|
  order = Order.new
  order.id = row['id']
  order.email = row['email']
  order.address = row['address']
  order.credit_name = row['credit_name']
  order.credit_expire = row['credit_expire']
  order.security_code = row['security_code']
  order.zip = row['zip']
  successful = order.save
  if !successful
    order_failures << order
    puts "Failed to save work: #{order.inspect}"
  else
    puts "Created work: #{order.inspect}"
  end
end

puts "Added #{Order.count} order records"
puts "#{order_failures.length} order failed to save"


ORDER_FILE = Rails.root.join('db', 'orders_seeds.csv')
puts "Loading raw work data from #{ORDER_FILE}"

order_failures = []
CSV.foreach(ORDER_FILE, :headers => true) do |row|
  order = Order.new
  order.id = row['id']
  order.email = row['email']
  order.address = row['address']
  order.credit_name = row['credit_name']
  order.credit_expire = row['credit_expire']
  order.security_code = row['security_code']
  order.zip = row['zip']
  successful = order.save
  if !successful
    order_failures << order
    puts "Failed to save work: #{order.inspect}"
  else
    puts "Created work: #{order.inspect}"
  end
end

puts "Added #{Order.count} order records"
puts "#{order_failures.length} order failed to save"


PRODUCT_FILE = Rails.root.join('db', 'products_seeds.csv')
puts "Loading raw work data from #{PRODUCT_FILE}"

product_failures = []
CSV.foreach(PRODUCT_FILE, :headers => true) do |row|
  product = Product.new
  product.id = row['id']
  product.name = row['name']
  product.description = row['description']
  product.inventory = row['inventory']
  product.price = row['price']
  product.category = row['category']
  product.photo = row['photo']
  product.rating = row['rating']
  successful = order.save
  if !successful
    product_failures << product
    puts "Failed to save work: #{product.inspect}"
  else
    puts "Created work: #{product.inspect}"
  end
end

puts "Added #{Product.count} product records"
puts "#{product_failures.length} product failed to save"
