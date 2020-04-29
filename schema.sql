CREATE DATABASE classic_car_parts;

CREATE TABLE listings
(
    id SERIAL PRIMARY KEY,
    headline Text,
    description Text,
    user_id Integer,
    suburb Text,
    post_date timestamp
);

CREATE TABLE users
(
    id SERIAL PRIMARY KEY,
    name Text,
    email TEXT,
    password_digest TEXT

)
