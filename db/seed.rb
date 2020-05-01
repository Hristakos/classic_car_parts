require 'pg'
require_relative '../models/listing'
require_relative '../models/user'

run_sql("drop table users;",[])
run_sql("drop table listings;",[])
run_sql("
CREATE TABLE listings
(
    id SERIAL PRIMARY KEY,
    headline Text,
    description Text,
    user_id Integer,
    suburb TEXT,
    post_date timestamp,
    price money,
    img_url Text,
    messages Text []
);",[])

run_sql("
CREATE TABLE users
(
    id SERIAL PRIMARY KEY,
    name Text,
    email TEXT,
    password_digest TEXT

);",[])
suburbs = ["Ascot Vale",
          "Balwyn",
          "Croydon",
          "Doncaster",
          "Essendon",
          "Footscray",
          "Greenvale",
          "Highet",
          "Ivanhoe",
          "Jacana",
          "Kensington",
          "Lilydale",
          "Moonee Ponds",
          "Newport",
          "Oakleigh",
          "Port Melbourne",
          "Richmond",
          "Strathmore",
          "Thornbury",
          "Upway",
          "Vermont",
          "Williamstown",
          "Yarraville"]
# create 10 dummy users

makes = ["Ford", "Holden","Chrysler"]
(1..10).each do |n|

    create_user("user#{n} name ","user#{n}@gmail.com","pudding#{n}")
    puts "created user #{n}...."
  end
# create 10 dummy listings
(1..10).each do |n|
  create_listing(
    "#{makes.sample} number #{n}", 
    "description #{n}",
    n,
    suburbs.sample,
    Time.now - n * [100000,2000000,300000,700000, 250000, 7700000].sample,
    12.50 * n * [5,25,15,2,6,78].sample,
    "/Users/peterhristakos/Downloads/background.png"
  )
  puts "created listing #{n}...."
end

puts "done"