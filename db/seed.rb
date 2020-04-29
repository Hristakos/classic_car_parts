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
    price money
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
(1..10).each do |n|
    create_user("user#{n} name ","user#{n}@gmail.com","pudding#{n}")
end
# create 10 dummy listings
(1..10).each do |n|
  create_listing(
    "listing number #{n}", 
    "description #{n}",
    n,
    suburbs.sample,
    Time.now - n * 100000,
    12.50 * n

  )
end