require 'pg'
require_relative '../models/listing'
require_relative '../models/user'


# create 10 dummy listings
(1..10).each do |n|
  create_listing(
    "listing number #{n}", 
    "description #{n}"
  )
end