DROP TABLE IF EXISTS nationality CASCADE;
DROP TABLE IF EXISTS competition CASCADE;
DROP TABLE IF EXISTS discipline CASCADE;
DROP TABLE IF EXISTS event CASCADE;
DROP TABLE IF EXISTS round CASCADE;
DROP TABLE IF EXISTS race CASCADE;
DROP TABLE IF EXISTS athlete CASCADE;
DROP TABLE IF EXISTS result CASCADE;

-- Create the nationality table
CREATE TABLE nationality (
    id SERIAL PRIMARY KEY,
    country_name VARCHAR(100),
    country_abbr VARCHAR(3)
);

-- Create the competition table
CREATE TABLE competition (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    start_date DATE,
    end_date DATE,
    year INT,
    location VARCHAR(100)
);

-- Create the discipline table
CREATE TABLE discipline (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    is_men BOOLEAN,
    distance INT
);

-- Create the event table
CREATE TABLE event (
    id SERIAL PRIMARY KEY,
    competition_id INT REFERENCES competition(id),
    discipline_id INT REFERENCES discipline(id)
);

-- Create the round table
CREATE TABLE round (
    id SERIAL PRIMARY KEY,
    event_id INT REFERENCES event(id),
    round_name VARCHAR(50),
    round_number INT,
    is_final BOOLEAN
);

-- Create the race table
CREATE TABLE race (
    id SERIAL PRIMARY KEY,
    round_id INT REFERENCES round(id),
    round_name VARCHAR(50),
    race_number INT,
    race_date DATE,
    is_final BOOLEAN,
    wind DECIMAL(5, 2)
);

-- Create the athlete table
CREATE TABLE athlete (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    nationality_id INT REFERENCES nationality(id),
    birth_date DATE
);

-- Create the result table
CREATE TABLE result (
    race_id INT REFERENCES race(id),
    athlete_id INT REFERENCES athlete(id),
    result TIME,
    place INT,
    is_dsq BOOLEAN,
    is_dns BOOLEAN,
    is_dnf BOOLEAN,
    PRIMARY KEY (race_id, athlete_id)
);

-- Insert dummy data into nationality table
INSERT INTO nationality (country_name, country_abbr) VALUES
('United States', 'USA'),
('Canada', 'CAN'),
('United Kingdom', 'GBR'),
('Germany', 'GER'),
('France', 'FRA'),
('Jamaica', 'JAM'),
('Kenya', 'KEN'),
('Ethiopia', 'ETH'),
('Australia', 'AUS'),
('China', 'CHN');

-- Insert dummy data into competition table
INSERT INTO competition (name, start_date, end_date, year, location) VALUES
('Olympic Games 2020', '2020-07-23', '2020-08-08', 2020, 'Tokyo'),
('World Athletics 2019', '2019-09-28', '2019-10-06', 2019, 'Doha'),
('European Championship 2018', '2018-08-06', '2018-08-12', 2018, 'Berlin'),
('Commonwealth Games 2018', '2018-04-04', '2018-04-15', 2018, 'Gold Coast'),
('Asian Games 2018', '2018-08-18', '2018-09-02', 2018, 'Jakarta'),
('Pan American Games 2019', '2019-07-26', '2019-08-11', 2019, 'Lima'),
('Youth Olympics 2018', '2018-10-06', '2018-10-18', 2018, 'Buenos Aires'),
('African Games 2019', '2019-08-19', '2019-08-31', 2019, 'Rabat'),
('Mediterranean Games 2018', '2018-06-22', '2018-07-01', 2018, 'Tarragona'),
('SEA Games 2019', '2019-11-30', '2019-12-11', 2019, 'Manila');

-- Insert dummy data into discipline table
INSERT INTO discipline (name, is_men, distance) VALUES
('100 meters', TRUE, 100),
('200 meters', TRUE, 200),
('400 meters', FALSE, 400),
('800 meters', TRUE, 800),
('1500 meters', FALSE, 1500),
('5000 meters', TRUE, 5000),
('10000 meters', FALSE, 10000),
('Marathon', TRUE, 42195),
('100 meters', FALSE, 100),
('400 meters hurdles', TRUE, 400);

-- Insert dummy data into event table
INSERT INTO event (competition_id, discipline_id) VALUES
(1, 1), (1, 2), (2, 3), (2, 4), (3, 5), (3, 6), (4, 7), (5, 8), (6, 9), (6, 10);

-- Insert dummy data into round table
INSERT INTO round (event_id, round_name, round_number, is_final) VALUES
(1, 'Heat 1', 1, FALSE),
(1, 'Heat 2', 2, FALSE),
(1, 'Final', 3, TRUE),
(2, 'Heat 1', 1, FALSE),
(2, 'Heat 2', 2, FALSE),
(2, 'Final', 3, TRUE),
(3, 'Qualifying', 1, FALSE),
(3, 'Semifinal', 2, FALSE),
(3, 'Final', 3, TRUE),
(4, 'Heat 1', 1, FALSE);

-- Insert dummy data into race table
INSERT INTO race (round_id, round_name, race_number, race_date, is_final, wind) VALUES
(1, 'Heat 1', 1, '2020-07-25', FALSE, 1.2),
(2, 'Heat 2', 1, '2020-07-25', FALSE, 0.8),
(3, 'Final', 1, '2020-07-26', TRUE, 0.5),
(4, 'Heat 1', 1, '2019-09-30', FALSE, 1.5),
(5, 'Heat 2', 1, '2019-09-30', FALSE, -0.3),
(6, 'Final', 1, '2019-10-01', TRUE, -0.1),
(7, 'Qualifying', 1, '2018-08-07', FALSE, 0.0),
(8, 'Semifinal', 1, '2018-08-09', FALSE, 1.0),
(9, 'Final', 1, '2018-08-11', TRUE, -1.2),
(10, 'Heat 1', 1, '2018-04-05', FALSE, 2.0);

-- Insert dummy data into athlete table
INSERT INTO athlete (first_name, last_name, nationality_id, birth_date) VALUES
('Usain', 'Bolt', 6, '1986-08-21'),
('Mo', 'Farah', 8, '1983-03-23'),
('Allyson', 'Felix', 1, '1985-11-18'),
('Shelly-Ann', 'Fraser-Pryce', 6, '1986-12-27'),
('Justin', 'Gatlin', 1, '1982-02-10'),
('Eliud', 'Kipchoge', 7, '1984-11-05'),
('Sifan', 'Hassan', 3, '1993-01-01'),
('Dina', 'Asher-Smith', 3, '1995-12-04'),
('Yohan', 'Blake', 6, '1989-12-26'),
('Caster', 'Semenya', 4, '1991-01-07');

-- Insert dummy data into result table
INSERT INTO result (race_id, athlete_id, result, place, is_dsq, is_dns, is_dnf) VALUES
(1, 1, '00:09:58', 1, FALSE, FALSE, FALSE),
(1, 9, '00:09:59', 2, FALSE, FALSE, FALSE),  -- Corrected from 00:09:97
(1, 5, '00:10:10', 3, FALSE, FALSE, FALSE),
(2, 3, '00:10:45', 1, FALSE, FALSE, FALSE),
(2, 6, '00:10:55', 2, FALSE, FALSE, FALSE),
(3, 1, '00:09:36', 1, FALSE, FALSE, FALSE),
(3, 9, '00:09:22', 2, FALSE, FALSE, FALSE),
(4, 2, '00:03:02', 1, FALSE, FALSE, FALSE),
(4, 7, '00:03:45', 2, FALSE, FALSE, FALSE),
(5, 4, '00:03:48', 3, FALSE, FALSE, FALSE);

SELECT * FROM nationality;
SELECT * FROM competition;
SELECT * FROM discipline;
SELECT * FROM event;
SELECT * FROM round;
SELECT * FROM race;
SELECT * FROM athlete;
SELECT * FROM result;

-- 8. Calculate the Difference Between Daily Wind Speed Averages
SELECT
    race_date,
    ROUND(AVG(wind), 3) AS avg_wind,
    ABS(ROUND(AVG(wind) - LAG(AVG(wind)) OVER(ORDER BY race_date), 3)) 
    AS avg_wind_delta
FROM 
    race
GROUP BY
    race_date;

-- Begin transaction to group all insertions
BEGIN;

-- Insert "Rio de Janeiro Olympic Games" into competition
INSERT INTO competition (name, start_date, end_date, year, location) VALUES
('Rio de Janeiro Olympic Games', '2016-08-05', '2016-08-21', 2016, 'Rio de Janeiro');

-- Insert "Women's Marathon" into discipline
INSERT INTO discipline (name, is_men, distance) VALUES
('Women''s Marathon', FALSE, 42195);

-- Insert event linking "Rio de Janeiro Olympic Games" and "Women's Marathon"
INSERT INTO event (competition_id, discipline_id) VALUES
((SELECT id FROM competition WHERE name = 'Rio de Janeiro Olympic Games'), 
 (SELECT id FROM discipline WHERE name = 'Women''s Marathon'));

-- Insert final round for the event
INSERT INTO round (event_id, round_name, round_number, is_final) VALUES
((SELECT id FROM event 
  WHERE competition_id = (SELECT id FROM competition WHERE name = 'Rio de Janeiro Olympic Games') 
  AND discipline_id = (SELECT id FROM discipline WHERE name = 'Women''s Marathon')), 
 'Final', 1, TRUE);

-- Insert race for the final round
INSERT INTO race (round_id, round_name, race_number, race_date, is_final, wind) VALUES
((SELECT id FROM round 
  WHERE event_id = (SELECT id FROM event 
    WHERE competition_id = (SELECT id FROM competition WHERE name = 'Rio de Janeiro Olympic Games') 
    AND discipline_id = (SELECT id FROM discipline WHERE name = 'Women''s Marathon')) 
  AND round_name = 'Final'), 
 'Final', 1, '2016-08-14', TRUE, 0.5);

-- Insert athletes
INSERT INTO athlete (first_name, last_name, nationality_id, birth_date) VALUES
('Mare', 'Dibaba', (SELECT id FROM nationality WHERE country_name = 'Ethiopia'), '1989-10-20'),  -- Ethiopia
('Jemima', 'Sumgong', (SELECT id FROM nationality WHERE country_name = 'Kenya'), '1984-12-21'),  -- Kenya
('Tatyana', 'Arkhipova', (SELECT id FROM nationality WHERE country_name = 'Russia'), '1983-04-22');  -- Russia

-- Insert results for the race
INSERT INTO result (race_id, athlete_id, result, place, is_dsq, is_dns, is_dnf) VALUES
((SELECT id FROM race 
  WHERE round_id = (SELECT id FROM round 
    WHERE event_id = (SELECT id FROM event 
      WHERE competition_id = (SELECT id FROM competition WHERE name = 'Rio de Janeiro Olympic Games') 
      AND discipline_id = (SELECT id FROM discipline WHERE name = 'Women''s Marathon')) 
    AND round_name = 'Final')), 
 (SELECT id FROM athlete WHERE first_name = 'Mare' AND last_name = 'Dibaba'), '02:24:15', 1, FALSE, FALSE, FALSE),
((SELECT id FROM race 
  WHERE round_id = (SELECT id FROM round 
    WHERE event_id = (SELECT id FROM event 
      WHERE competition_id = (SELECT id FROM competition WHERE name = 'Rio de Janeiro Olympic Games') 
      AND discipline_id = (SELECT id FROM discipline WHERE name = 'Women''s Marathon')) 
    AND round_name = 'Final')), 
 (SELECT id FROM athlete WHERE first_name = 'Jemima' AND last_name = 'Sumgong'), '02:24:25', 2, FALSE, FALSE, FALSE),
((SELECT id FROM race 
  WHERE round_id = (SELECT id FROM round 
    WHERE event_id = (SELECT id FROM event 
      WHERE competition_id = (SELECT id FROM competition WHERE name = 'Rio de Janeiro Olympic Games') 
      AND discipline_id = (SELECT id FROM discipline WHERE name = 'Women''s Marathon')) 
    AND round_name = 'Final')), 
 (SELECT id FROM athlete WHERE first_name = 'Tatyana' AND last_name = 'Arkhipova'), '02:24:45', 3, FALSE, FALSE, FALSE);

-- Commit transaction to save all changes
COMMIT;


-- 9. Compare the Best and Previous Results
SELECT  
    re.place,
    a.first_name,
    a.last_name,
    ABS(EXTRACT(EPOCH FROM re.result) - 
        FIRST_VALUE(EXTRACT(EPOCH FROM re.result)) 
        OVER(ORDER BY re.result ASC)) AS comparison_to_best,
    ABS(EXTRACT(EPOCH FROM re.result) - 
        LAG(EXTRACT(EPOCH FROM re.result)) 
        OVER(ORDER BY re.result DESC)) AS comparison_to_previous
FROM
    competition AS c
JOIN 
    event AS e 
    ON c.id = e.competition_id
JOIN 
    discipline AS d 
    ON d.id = e.discipline_id
JOIN 
    round AS ro 
    ON e.id = ro.event_id
JOIN 
    race AS ra 
    ON ra.id = ro.id
JOIN 
    result AS re 
    ON re.race_id = ra.id
JOIN 
    athlete AS a 
    ON a.id = re.athlete_id
WHERE 
    c.name = 'Rio de Janeiro Olympic Games'
    AND d.name = 'Women''s Marathon'
    AND ro.is_final IS TRUE
ORDER BY re.place;