DROP TABLE IF EXISTS customer CASCADE;
DROP TABLE IF EXISTS movie CASCADE;
DROP TABLE IF EXISTS review CASCADE;
DROP TABLE IF EXISTS single_rental CASCADE;
DROP TABLE IF EXISTS subscription CASCADE;
DROP TABLE IF EXISTS giftcard CASCADE;

-- Create customer table
CREATE TABLE customer (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    join_date DATE,
    country VARCHAR(50)
);

-- Create movie table
CREATE TABLE movie (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100),
    release_year INT,
    genre VARCHAR(50),
    editor_ranking INT
);

-- Create review table
CREATE TABLE review (
    id SERIAL PRIMARY KEY,
    rating INT,
    customer_id INT REFERENCES customer(id),
    movie_id INT REFERENCES movie(id)
);

-- Create single_rental table
CREATE TABLE single_rental (
    id SERIAL PRIMARY KEY,
    rental_date DATE,
    rental_period INT,
    platform VARCHAR(50),
    customer_id INT REFERENCES customer(id),
    movie_id INT REFERENCES movie(id),
    payment_date DATE,
    payment_amount NUMERIC(10, 2)
);

-- Create subscription table
CREATE TABLE subscription (
    id SERIAL PRIMARY KEY,
    length INT,  -- length in days
    start_date DATE,
    platform VARCHAR(50),
    payment_date DATE,
    payment_amount NUMERIC(10, 2),
    customer_id INT REFERENCES customer(id)
);

-- Create giftcard table
CREATE TABLE giftcard (
    id SERIAL PRIMARY KEY,
    amount_worth NUMERIC(10, 2),
    customer_id INT REFERENCES customer(id),
    payment_date DATE,
    payment_amount NUMERIC(10, 2)
);

-- Insert into customer table
INSERT INTO customer (first_name, last_name, join_date, country)
VALUES
('John', 'Doe', '2023-01-15', 'USA'),
('Jane', 'Smith', '2023-02-20', 'Canada'),
('Alice', 'Johnson', '2023-03-12', 'UK'),
('Bob', 'Williams', '2023-04-18', 'Australia'),
('Charlie', 'Brown', '2023-05-05', 'Germany'),
('David', 'Miller', '2023-06-23', 'France'),
('Eve', 'Davis', '2023-07-14', 'Spain'),
('Frank', 'Garcia', '2023-08-01', 'Mexico'),
('Grace', 'Martinez', '2023-09-10', 'Italy'),
('Hank', 'Rodriguez', '2023-10-05', 'Brazil');

-- Insert into movie table
INSERT INTO movie (title, release_year, genre, editor_ranking)
VALUES
('The Matrix', 1999, 'Sci-Fi', 9),
('Inception', 2010, 'Sci-Fi', 10),
('The Godfather', 1972, 'Crime', 10),
('Titanic', 1997, 'Romance', 8),
('The Dark Knight', 2008, 'Action', 9),
('Pulp Fiction', 1994, 'Crime', 9),
('The Shawshank Redemption', 1994, 'Drama', 10),
('Fight Club', 1999, 'Drama', 9),
('Forrest Gump', 1994, 'Drama', 8),
('Gladiator', 2000, 'Action', 8);

-- Insert into review table
INSERT INTO review (rating, customer_id, movie_id)
VALUES
(5, 1, 1),
(4, 2, 2),
(5, 3, 3),
(3, 4, 4),
(5, 5, 5),
(4, 6, 6),
(5, 7, 7),
(4, 8, 8),
(5, 9, 9),
(3, 10, 10);

-- Insert into single_rental table
INSERT INTO single_rental (rental_date, rental_period, platform, customer_id, movie_id, payment_date, payment_amount)
VALUES
('2023-09-01', 7, 'Netflix', 1, 1, '2023-09-01', 3.99),
('2023-09-05', 3, 'Amazon', 2, 2, '2023-09-05', 2.99),
('2023-09-10', 5, 'Hulu', 3, 3, '2023-09-10', 4.50),
('2023-09-12', 2, 'Disney+', 4, 4, '2023-09-12', 1.99),
('2023-09-15', 4, 'HBO Max', 5, 5, '2023-09-15', 5.00),
('2023-09-20', 7, 'Netflix', 6, 6, '2023-09-20', 3.99),
('2023-09-25', 5, 'Amazon', 7, 7, '2023-09-25', 2.99),
('2023-09-28', 3, 'Hulu', 8, 8, '2023-09-28', 4.50),
('2023-10-01', 6, 'Disney+', 9, 9, '2023-10-01', 4.99),
('2023-10-05', 2, 'HBO Max', 10, 10, '2023-10-05', 3.50);

-- Insert into subscription table
INSERT INTO subscription (length, start_date, platform, payment_date, payment_amount, customer_id)
VALUES
(30, '2023-01-01', 'Netflix', '2023-01-01', 10.99, 1),
(60, '2023-02-01', 'Amazon', '2023-02-01', 19.99, 2),
(90, '2023-03-01', 'Hulu', '2023-03-01', 29.99, 3),
(30, '2023-04-01', 'Disney+', '2023-04-01', 12.99, 4),
(60, '2023-05-01', 'HBO Max', '2023-05-01', 24.99, 5),
(90, '2023-06-01', 'Netflix', '2023-06-01', 29.99, 6),
(30, '2023-07-01', 'Amazon', '2023-07-01', 10.99, 7),
(60, '2023-08-01', 'Hulu', '2023-08-01', 19.99, 8),
(90, '2023-09-01', 'Disney+', '2023-09-01', 29.99, 9),
(30, '2023-10-01', 'HBO Max', '2023-10-01', 12.99, 10);

-- Insert into giftcard table
INSERT INTO giftcard (amount_worth, customer_id, payment_date, payment_amount)
VALUES
(50.00, 1, '2023-09-01', 50.00),
(25.00, 2, '2023-09-05', 25.00),
(75.00, 3, '2023-09-10', 75.00),
(100.00, 4, '2023-09-12', 100.00),
(20.00, 5, '2023-09-15', 20.00),
(50.00, 6, '2023-09-20', 50.00),
(75.00, 7, '2023-09-25', 75.00),
(100.00, 8, '2023-09-28', 100.00),
(30.00, 9, '2023-10-01', 30.00),
(40.00, 10, '2023-10-05', 40.00);

SELECT * FROM customer;
SELECT * FROM movie;
SELECT * FROM review;
SELECT * FROM single_rental;
SELECT * FROM subscription;
SELECT * FROM giftcard;

-- 1. Rank Rentals by Price
SELECT
  sr.rental_date,
  m.title,
  m.genre,
  sr.payment_amount,
  RANK() OVER(PARTITION BY m.genre 
  ORDER BY sr.payment_amount DESC) AS rank
FROM
  single_rental AS sr
JOIN
  movie AS m
  ON sr.movie_id = m.id;

-- 2. Find 2nd Giftcard Purchasing Customer
WITH ranked_giftcard AS (
    SELECT 
        *,
        RANK() OVER(ORDER BY payment_date DESC) AS rank
    FROM
        giftcard
)
SELECT
    c.first_name,
    c.last_name,
    rg.payment_date
FROM
    ranked_giftcard AS rg
JOIN
    customer AS c
    ON rg.customer_id = c.id
WHERE
    rg.rank = 2;

-- 3. Calculate Running Total for Payments
SELECT
    id,
    rental_date,
    payment_amount,
    SUM(payment_amount) OVER(
        ORDER BY payment_date 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS running_total
FROM 
    single_rental;