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
    user_id Integer
);",[])

run_sql("
CREATE TABLE users
(
    id SERIAL PRIMARY KEY,
    email TEXT,
    password_digest TEXT

);",[])

# create 10 dummy users
(1..10).each do |n|
    create_user("user#{n}@gmail.com","pudding#{n}")
end
# create 10 dummy listings
(1..10).each do |n|
  create_listing(
    "listing number #{n}", 
    "description #{n}",
    n

  )
end