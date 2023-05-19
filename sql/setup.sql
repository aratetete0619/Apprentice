-- Create Database
CREATE DATABASE IF NOT EXISTS TVGuide;
USE TVGuide;
-- Create Tables
CREATE TABLE Users (
  id BIGINT(20) AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE Channels (
  id BIGINT(20) AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);
CREATE TABLE Programs (
  id BIGINT(20) AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  description LONGTEXT
);
CREATE TABLE Seasons (
  id BIGINT(20) AUTO_INCREMENT PRIMARY KEY,
  program_id BIGINT(20) NOT NULL,
  season_number INT(11) NOT NULL,
  UNIQUE(program_id, season_number)
);
CREATE TABLE Episodes (
  id BIGINT(20) AUTO_INCREMENT PRIMARY KEY,
  season_id BIGINT(20) NOT NULL,
  episode_number INT(11) NOT NULL,
  title VARCHAR(100) NOT NULL,
  description LONGTEXT,
  duration INT(11) NOT NULL,
  release_date DATE NOT NULL,
  total_viewers_number BIGINT(20) NOT NULL,
  UNIQUE(season_id, episode_number)
);
CREATE TABLE Genres (
  id BIGINT(20) AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);
CREATE TABLE Program_Genres (
  program_id BIGINT(20) NOT NULL,
  genre_id BIGINT(20) NOT NULL
);
CREATE TABLE Channel_Episodes (
  channel_id BIGINT(20) NOT NULL,
  episode_id BIGINT(20) NOT NULL,
  broadcast_time DATETIME NOT NULL,
  broadcast_viewers_number BIGINT(20) NOT NULL,
  PRIMARY KEY(channel_id, episode_id, broadcast_time)
);
-- Insert Test Data
INSERT INTO Users (name, email)
VALUES ('John Doe', 'johndoe@example.com');
INSERT INTO Channels (name)
VALUES ('Channel 1'),
  ('Channel 2');
INSERT INTO Programs (title, description)
VALUES ('Program 1', 'Description of Program 1'),
  ('Program 2', 'Description of Program 2');
INSERT INTO Seasons (program_id, season_number)
VALUES (1, 1),
  (2, 1);
INSERT INTO Episodes (
    season_id,
    episode_number,
    title,
    description,
    duration,
    release_date,
    total_viewers_number
  )
VALUES (
    1,
    1,
    'Episode 1',
    'Description of Episode 1',
    60,
    '2023-05-11',
    1000
  ),
  (
    2,
    1,
    'Episode 2',
    'Description of Episode 2',
    90,
    '2023-05-11',
    2000
  );
INSERT INTO Genres (name)
VALUES ('Genre 1'),
  ('Genre 2');
INSERT INTO Program_Genres (program_id, genre_id)
VALUES (1, 1),
  (2, 2);
INSERT INTO Channel_Episodes (
    channel_id,
    episode_id,
    broadcast_time,
    broadcast_viewers_number
  )
VALUES (1, 1, '2023-05-12 20:00:00', 500),
  (2, 2, '2023-05-12 21:00:00', 800);
