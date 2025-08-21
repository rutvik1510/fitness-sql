Personal Fitness & Workout Log SQL Project 💪
This project demonstrates the design, implementation, and querying of a relational database to track personal fitness activities, including user profiles, exercises, workout sessions, and detailed performance metrics. It's built to provide insights into workout habits and progress over time.

🎯 Objective
The primary goal of this project is to create a robust and flexible database solution for individuals to log their fitness journey. It aims to:

Organize workout data efficiently.

Track performance for various exercises (reps, weight, distance, calories).

Enable analysis of workout consistency and progress.

📊 Database Schema
The database is structured around four interconnected tables, designed to minimize redundancy and ensure data integrity:

Users Table: Stores basic information about each individual tracking their fitness.

user_id (PK): Unique identifier for each user.

username: Unique username.

email: User's email address.

join_date: Date the user joined.

Exercises Table: Catalogs different types of exercises.

exercise_id (PK): Unique identifier for each exercise.

exercise_name: Name of the exercise (e.g., 'Bench Press', 'Running').

exercise_type: Category (e.g., 'Strength', 'Cardio').

target_muscle_group: Primary muscle group targeted.

Workouts Table: Records information about each individual workout session.

workout_id (PK): Unique identifier for each workout.

user_id (FK): Links to the Users table (who performed the workout).

workout_date: Date of the workout.

start_time: Workout start time.

end_time: Workout end time.

duration_minutes: Total duration of the workout.

Workout_Details Table: Stores specific performance metrics for each exercise within a workout. This is an associative table handling the many-to-many relationship between Workouts and Exercises.

detail_id (PK): Unique identifier for each detail entry.

workout_id (FK): Links to the Workouts table.

exercise_id (FK): Links to the Exercises table.

set_number: The set number for a given exercise within a workout.

reps: Number of repetitions.

weight_kg: Weight lifted in kilograms.

distance_km: Distance covered in kilometers.

calories_burned: Estimated calories burned for that set/exercise instance.

🔑 Key Features & Functionality
The project demonstrates the ability to perform various data manipulation and analytical tasks:

Data Definition (DDL): Creation of tables with appropriate data types, primary keys, foreign keys, and unique constraints.

Data Manipulation (DML): Insertion of sample data to populate the database.

Schema Evolution: Demonstrated modifying a table's schema (removing duration_seconds and adding calories_burned in Workout_Details) using SQLite's migration techniques.

Data Querying & Analysis (DQL):

Retrieving detailed workout logs for specific users.

Calculating total workouts per user.

Identifying maximum weight lifted for strength exercises.

Tracking total distance and calories burned for cardio activities.

Aggregating total calories burned per workout session.

Utilizing JOIN operations to combine data across multiple tables.

Employing aggregate functions (SUM, MAX, COUNT) and GROUP BY for summarization.

🛠️ Technologies Used
Database: SQLite (lightweight, file-based relational database)

SQL Client: DB Browser for SQLite (for graphical interface and execution)

Language: SQL (Structured Query Language)

🚀 How to Set Up and Run
Install DB Browser for SQLite: Download and install the application from sqlitebrowser.org.

Create a New Database:

Open DB Browser for SQLite.

Click "New Database" and save the file as fitness_log.db (or any other .db name) on your Desktop.

Execute the SQL Script:

Go to the "Execute SQL" tab in DB Browser for SQLite.

Copy the entire content of the fitness_log_project_script.sql file (which contains all CREATE TABLE, INSERT INTO, and SELECT statements).

Paste the entire script into the SQL editor.

Click the blue "play" button to execute all commands.

Explore Data & Results:

Navigate to the "Browse Data" tab to visually inspect your populated tables.

View the results of the analytical queries in the bottom pane of the "Execute SQL" tab.

💡 Future Enhancements
Implement more advanced progress tracking (e.g., 1-rep max calculator, personal bests over time using window functions).

Add a Goals table to set and track specific user fitness goals.

Develop a simple front-end application (e.g., using Python Flask/Django or Node.js) to interact with the database.

Integrate with external APIs for more accurate calorie burn estimations.
