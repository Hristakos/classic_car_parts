require 'pg'
require_relative '../models/listing'

# create 10 dummy listings
(1..10).each do |n|
  create_listing(
    "listing number #{n}", 
    "description #{n}"
  )
end