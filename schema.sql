CREATE DATABASE classic_car_parts;

CREATE TABLE listings
(
    id SERIAL PRIMARY KEY,
    headline Text,
    description Text,
    user_id Integer
);

CREATE TABLE users
(
    id SERIAL PRIMARY KEY,
    email TEXT,
    password_digest TEXT

)
