DROP TABLE IF EXISTS statistics CASCADE;
DROP TABLE IF EXISTS website CASCADE;

-- Create the website table
CREATE TABLE website (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    budget NUMERIC(10, 2) NOT NULL,
    opened DATE NOT NULL
);

-- Create the statistics table
CREATE TABLE statistics (
    id SERIAL PRIMARY KEY,
    website_id INT REFERENCES website(id) ON DELETE CASCADE,
    day DATE NOT NULL,
    users INT NOT NULL,
    impressions INT NOT NULL,
    clicks INT NOT NULL,
    revenue NUMERIC(10, 2) NOT NULL
);

-- Insert dummy data into website table
INSERT INTO website (name, budget, opened) 
VALUES 
('TechWorld', 5000.00, '2016-01-01'),
('NewsDaily', 7500.00, '2016-01-10'),
('ShopMart', 10000.00, '2016-02-01'),
('HealthPlus', 4000.00, '2016-02-15'),
('EduLearn', 3000.00, '2016-03-01'),
('AutoDrive', 6000.00, '2016-03-10'),
('FoodieBlog', 3500.00, '2016-04-01'),
('TravelExplorer', 8000.00, '2016-04-15'),
('FashionTrends', 4500.00, '2016-05-01'),
('GameZone', 5500.00, '2016-05-10');

-- Insert dummy data into statistics table
INSERT INTO statistics (website_id, day, users, impressions, clicks, revenue) 
VALUES
(1, '2016-05-01', 1000, 5000, 100, 50.00),
(1, '2016-05-02', 1200, 5200, 110, 60.00),
(2, '2016-05-01', 1500, 6000, 130, 80.00),
(2, '2016-05-02', 1600, 6100, 140, 90.00),
(3, '2016-05-01', 2000, 8000, 200, 100.00),
(3, '2016-05-02', 2100, 8200, 210, 110.00),
(4, '2016-05-01', 1800, 7500, 170, 85.00),
(5, '2016-05-02', 1300, 6400, 120, 65.00),
(6, '2016-05-01', 900, 4500, 90, 45.00),
(7, '2016-05-02', 1100, 4800, 100, 55.00);

SELECT * FROM website;
SELECT * FROM statistics;

-- 10. Look Ahead with the LEAD() Function
SELECT
    day,
    users,
    LEAD(users, 7, -1) OVER(ORDER BY day)
FROM 
    statistics
WHERE
    website_id = 2
    AND day BETWEEN '2016-05-01' AND '2016-05-14'; 

-- 11. Look Back with the LAG() Function
SELECT
    day, 
    revenue,
    LAG(revenue, 3, -1.00) OVER(ORDER BY day)
FROM 
    statistics
WHERE
    website_id = 3;