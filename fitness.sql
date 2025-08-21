--
-- SQL Script for Personal Fitness & Workout Log Database
--

-- SECTION 1: DATABASE SCHEMA DEFINITION
-- Creating tables with appropriate primary and foreign key relationships.

-- 1. Users Table: Stores basic information about the fitness tracker users.
CREATE TABLE Users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL UNIQUE,
    email TEXT UNIQUE,
    join_date TEXT NOT NULL -- YYYY-MM-DD
);

-- 2. Exercises Table: Catalogs different types of exercises.
CREATE TABLE Exercises (
    exercise_id INTEGER PRIMARY KEY AUTOINCREMENT,
    exercise_name TEXT NOT NULL UNIQUE,
    exercise_type TEXT, -- e.g., 'Strength', 'Cardio', 'Flexibility'
    target_muscle_group TEXT -- e.g., 'Chest', 'Legs', 'Core'
);

-- 3. Workouts Table: Stores information about each individual workout session.
CREATE TABLE Workouts (
    workout_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    workout_date TEXT NOT NULL, -- YYYY-MM-DD
    start_time TEXT, -- HH:MM:SS
    end_time TEXT, -- HH:MM:SS
    duration_minutes INTEGER,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- 4. Workout_Details Table: Records specific performance for each exercise within a workout.
--    This table handles the many-to-many relationship between Workouts and Exercises.
--    Includes 'calories_burned' and excludes 'duration_seconds'.
CREATE TABLE Workout_Details (
    detail_id INTEGER PRIMARY KEY AUTOINCREMENT,
    workout_id INTEGER NOT NULL,
    exercise_id INTEGER NOT NULL,
    set_number INTEGER NOT NULL,
    reps INTEGER,
    weight_kg REAL,
    distance_km REAL,
    calories_burned REAL, -- NEW COLUMN: Calories burned for this specific set/exercise instance
    UNIQUE(workout_id, exercise_id, set_number), -- Ensures unique set entries per exercise per workout
    FOREIGN KEY (workout_id) REFERENCES Workouts(workout_id),
    FOREIGN KEY (exercise_id) REFERENCES Exercises(exercise_id)
);


-- SECTION 2: POPULATING THE DATABASE WITH SAMPLE DATA
-- Data for users 'rutvik' and 'vamshi', their exercises, workouts, and performance details.

-- Insert Sample Users
INSERT INTO Users (username, email, join_date) VALUES
('rutvik', 'rutvik@example.com', '2024-01-01'),
('vamshi', 'vamshi@example.com', '2024-02-15');

-- Insert Sample Exercises
INSERT INTO Exercises (exercise_name, exercise_type, target_muscle_group) VALUES
('Bench Press', 'Strength', 'Chest'),
('Squat', 'Strength', 'Legs'),
('Deadlift', 'Strength', 'Full Body'),
('Running', 'Cardio', 'Legs'),
('Plank', 'Flexibility', 'Core'),
('Overhead Press', 'Strength', 'Shoulders');

-- Insert Sample Workouts for 'rutvik'
INSERT INTO Workouts (user_id, workout_date, start_time, end_time, duration_minutes) VALUES
((SELECT user_id FROM Users WHERE username = 'rutvik'), '2024-08-15', '08:00:00', '09:00:00', 60), -- Rutvik's Workout 1
((SELECT user_id FROM Users WHERE username = 'rutvik'), '2024-08-17', '18:30:00', '19:15:00', 45); -- Rutvik's Workout 2

-- Insert Sample Workouts for 'vamshi'
INSERT INTO Workouts (user_id, workout_date, start_time, end_time, duration_minutes) VALUES
((SELECT user_id FROM Users WHERE username = 'vamshi'), '2024-08-16', '17:00:00', '18:00:00', 60), -- Vamshi's Workout 1
((SELECT user_id FROM Users WHERE username = 'vamshi'), '2024-08-18', '06:30:00', '07:15:00', 45); -- Vamshi's Workout 2


-- Insert Sample Workout Details (adjusted for 'calories_burned' column)
-- Rutvik's Workout 1 (2024-08-15)
INSERT INTO Workout_Details (workout_id, exercise_id, set_number, reps, weight_kg, distance_km, calories_burned) VALUES
((SELECT workout_id FROM Workouts WHERE user_id = (SELECT user_id FROM Users WHERE username = 'rutvik') AND workout_date = '2024-08-15'), (SELECT exercise_id FROM Exercises WHERE exercise_name = 'Bench Press'), 1, 8, 60.0, NULL, 50.0),
((SELECT workout_id FROM Workouts WHERE user_id = (SELECT user_id FROM Users WHERE username = 'rutvik') AND workout_date = '2024-08-15'), (SELECT exercise_id FROM Exercises WHERE exercise_name = 'Bench Press'), 2, 8, 62.5, NULL, 55.0),
((SELECT workout_id FROM Workouts WHERE user_id = (SELECT user_id FROM Users WHERE username = 'rutvik') AND workout_date = '2024-08-15'), (SELECT exercise_id FROM Exercises WHERE exercise_name = 'Squat'), 1, 10, 70.0, NULL, 80.0),
((SELECT workout_id FROM Workouts WHERE user_id = (SELECT user_id FROM Users WHERE username = 'rutvik') AND workout_date = '2024-08-15'), (SELECT exercise_id FROM Exercises WHERE exercise_name = 'Running'), 1, NULL, NULL, 5.0, 300.0); -- 5 km run

-- Rutvik's Workout 2 (2024-08-17)
INSERT INTO Workout_Details (workout_id, exercise_id, set_number, reps, weight_kg, distance_km, calories_burned) VALUES
((SELECT workout_id FROM Workouts WHERE user_id = (SELECT user_id FROM Users WHERE username = 'rutvik') AND workout_date = '2024-08-17'), (SELECT exercise_id FROM Exercises WHERE exercise_name = 'Deadlift'), 1, 5, 80.0, NULL, 70.0),
((SELECT workout_id FROM Workouts WHERE user_id = (SELECT user_id FROM Users WHERE username = 'rutvik') AND workout_date = '2024-08-17'), (SELECT exercise_id FROM Exercises WHERE exercise_name = 'Plank'), 1, NULL, NULL, NULL, 20.0); -- Plank calories

-- Vamshi's Workout 1 (2024-08-16)
INSERT INTO Workout_Details (workout_id, exercise_id, set_number, reps, weight_kg, distance_km, calories_burned) VALUES
((SELECT workout_id FROM Workouts WHERE user_id = (SELECT user_id FROM Users WHERE username = 'vamshi') AND workout_date = '2024-08-16'), (SELECT exercise_id FROM Exercises WHERE exercise_name = 'Overhead Press'), 1, 8, 40.0, NULL, 45.0),
((SELECT workout_id FROM Workouts WHERE user_id = (SELECT user_id FROM Users WHERE username = 'vamshi') AND workout_date = '2024-08-16'), (SELECT exercise_id FROM Exercises WHERE exercise_name = 'Overhead Press'), 2, 8, 42.5, NULL, 50.0),
((SELECT workout_id FROM Workouts WHERE user_id = (SELECT user_id FROM Users WHERE username = 'vamshi') AND workout_date = '2024-08-16'), (SELECT exercise_id FROM Exercises WHERE exercise_name = 'Running'), 1, NULL, NULL, 6.5, 400.0); -- 6.5 km run

-- Vamshi's Workout 2 (2024-08-18)
INSERT INTO Workout_Details (workout_id, exercise_id, set_number, reps, weight_kg, distance_km, calories_burned) VALUES
((SELECT workout_id FROM Workouts WHERE user_id = (SELECT user_id FROM Users WHERE username = 'vamshi') AND workout_date = '2024-08-18'), (SELECT exercise_id FROM Exercises WHERE exercise_name = 'Squat'), 1, 10, 60.0, NULL, 70.0),
((SELECT workout_id FROM Workouts WHERE user_id = (SELECT user_id FROM Users WHERE username = 'vamshi') AND workout_date = '2024-08-18'), (SELECT exercise_id FROM Exercises WHERE exercise_name = 'Deadlift'), 1, 5, 75.0, NULL, 65.0);


-- SECTION 3: ANALYTICAL QUERIES
-- Queries to extract insights from the fitness log data.

-- Query 1: View All Workouts with User and Basic Details
SELECT
    U.username,
    W.workout_date,
    W.start_time,
    W.end_time,
    W.duration_minutes
FROM Workouts AS W
JOIN Users AS U ON W.user_id = U.user_id
ORDER BY W.workout_date DESC, W.start_time DESC;

-- Query 2: Get Details of a Specific Workout (e.g., Rutvik's first workout on 2024-08-15)
SELECT
    U.username,
    W.workout_date,
    E.exercise_name,
    WD.set_number,
    WD.reps,
    WD.weight_kg,
    WD.distance_km,
    WD.calories_burned
FROM Workout_Details AS WD
JOIN Workouts AS W ON WD.workout_id = W.workout_id
JOIN Users AS U ON W.user_id = U.user_id
JOIN Exercises AS E ON WD.exercise_id = E.exercise_id
WHERE U.username = 'rutvik' AND W.workout_date = '2024-08-15'
ORDER BY E.exercise_name, WD.set_number;

-- Query 3: Calculate Total Workouts per User
SELECT
    U.username,
    COUNT(W.workout_id) AS total_workouts_logged
FROM Users AS U
LEFT JOIN Workouts AS W ON U.user_id = W.user_id
GROUP BY U.username
ORDER BY total_workouts_logged DESC;

-- Query 4: Find Maximum Weight Lifted for 'Bench Press' by Each User
SELECT
    U.username,
    E.exercise_name,
    MAX(WD.weight_kg) AS max_weight_kg_lifted
FROM Workout_Details AS WD
JOIN Exercises AS E ON WD.exercise_id = E.exercise_id
JOIN Workouts AS W ON WD.workout_id = W.workout_id
JOIN Users AS U ON W.user_id = U.user_id
WHERE E.exercise_name = 'Bench Press'
GROUP BY U.username, E.exercise_name;

-- Query 5: Track Running Performance (Total Distance and Calories Burned) for Each User
SELECT
    U.username,
    E.exercise_name,
    SUM(WD.distance_km) AS total_distance_km,
    SUM(WD.calories_burned) AS total_calories_burned_running
FROM Workout_Details AS WD
JOIN Exercises AS E ON WD.exercise_id = E.exercise_id
JOIN Workouts AS W ON WD.workout_id = W.workout_id
JOIN Users AS U ON W.user_id = U.user_id
WHERE E.exercise_name = 'Running'
GROUP BY U.username, E.exercise_name
ORDER BY total_distance_km DESC;

-- Query 6: Calculate Total Calories Burned per Workout for Each User
SELECT
    U.username,
    W.workout_date,
    SUM(WD.calories_burned) AS total_calories_burned_workout
FROM Workout_Details AS WD
JOIN Workouts AS W ON WD.workout_id = W.workout_id
JOIN Users AS U ON W.user_id = U.user_id
GROUP BY U.username, W.workout_date
ORDER BY U.username, W.workout_date;