-- Create schema from exercise I(Point 2)
CREATE TABLE Student (
    id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    native_language VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE Course (
    name VARCHAR(50) NOT NULL,
    credits INT NOT NULL,
    PRIMARY KEY (name)
);

CREATE TABLE Enroll (
    student_id INT NOT NULL,
    course_name VARCHAR(50) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES Student(id),
    FOREIGN KEY (course_name) REFERENCES Course(name)
);

CREATE TABLE Specialization (
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (name)
);

CREATE TABLE takes (
    student_id INT NOT NULL,
    specialization_name VARCHAR(50) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES Student(id),
    FOREIGN KEY (specialization_name) REFERENCES Specialization(name)
);

-- Populate the tables with random data (Point 3)
INSERT INTO Student (id, name, native_language) VALUES (1, 'John', 'English');
INSERT INTO Student (id, name, native_language) VALUES (2, 'Mary', 'English');
INSERT INTO Student (id, name, native_language) VALUES (3, 'Peter', 'Russian');
INSERT INTO Student (id, name, native_language) VALUES (4, 'Anna', 'French');
INSERT INTO Student (id, name, native_language) VALUES (5, 'Alex', 'English');
INSERT INTO Student (id, name, native_language) VALUES (6, 'Sara', 'English');
INSERT INTO Student (id, name, native_language) VALUES (7, 'David', 'Russian');
INSERT INTO Student (id, name, native_language) VALUES (8, 'Kate', 'English');
INSERT INTO Student (id, name, native_language) VALUES (9, 'Bob', 'English');
INSERT INTO Student (id, name, native_language) VALUES (10, 'Alice', 'German');

INSERT INTO Course (name, credits) VALUES ('Math', 3);
INSERT INTO Course (name, credits) VALUES ('Physics', 1);
INSERT INTO Course (name, credits) VALUES ('Chemistry', 1);
INSERT INTO Course (name, credits) VALUES ('Biology', 2);
INSERT INTO Course (name, credits) VALUES ('Computer Science', 3);
INSERT INTO Course (name, credits) VALUES ('Robotics', 4);
INSERT INTO Course (name, credits) VALUES ('Artificial Intelligence', 8);
INSERT INTO Course (name, credits) VALUES ('Machine Learning', 4);
INSERT INTO Course (name, credits) VALUES ('Data Science', 5);
INSERT INTO Course (name, credits) VALUES ('Deep Learning', 6);

INSERT INTO Specialization (name) VALUES ('Robotics');
INSERT INTO Specialization (name) VALUES ('Artificial Intelligence');
INSERT INTO Specialization (name) VALUES ('Computer Science');
INSERT INTO Specialization (name) VALUES ('Data Science');
INSERT INTO Specialization (name) VALUES ('Ciber Security');

INSERT INTO takes (student_id, specialization_name) VALUES (1, 'Artificial Intelligence');
INSERT INTO takes (student_id, specialization_name) VALUES (2, 'Robotics');
INSERT INTO takes (student_id, specialization_name) VALUES (3, 'Ciber Security');
INSERT INTO takes (student_id, specialization_name) VALUES (4, 'Computer Science');
INSERT INTO takes (student_id, specialization_name) VALUES (5, 'Computer Science');
INSERT INTO takes (student_id, specialization_name) VALUES (6, 'Data Science');
INSERT INTO takes (student_id, specialization_name) VALUES (7, 'Robotics');
INSERT INTO takes (student_id, specialization_name) VALUES (8, 'Artificial Intelligence');
INSERT INTO takes (student_id, specialization_name) VALUES (9, 'Data Science');
INSERT INTO takes (student_id, specialization_name) VALUES (10, 'Computer Science');

INSERT INTO Enroll (student_id, course_name) VALUES (1, 'Artificial Intelligence');
INSERT INTO Enroll (student_id, course_name) VALUES (1, 'Machine Learning');
INSERT INTO Enroll (student_id, course_name) VALUES (1, 'Data Science');
INSERT INTO Enroll (student_id, course_name) VALUES (2, 'Robotics');
INSERT INTO Enroll (student_id, course_name) VALUES (2, 'Deep Learning');
INSERT INTO Enroll (student_id, course_name) VALUES (3, 'Math');
INSERT INTO Enroll (student_id, course_name) VALUES (3, 'Physics');
INSERT INTO Enroll (student_id, course_name) VALUES (3, 'Biology');
INSERT INTO Enroll (student_id, course_name) VALUES (4, 'Chemistry');
INSERT INTO Enroll (student_id, course_name) VALUES (4, 'Computer Science');
INSERT INTO Enroll (student_id, course_name) VALUES (5, 'Math');
INSERT INTO Enroll (student_id, course_name) VALUES (5, 'Physics');
INSERT INTO Enroll (student_id, course_name) VALUES (5, 'Biology');
INSERT INTO Enroll (student_id, course_name) VALUES (6, 'Chemistry');
INSERT INTO Enroll (student_id, course_name) VALUES (6, 'Computer Science');
INSERT INTO Enroll (student_id, course_name) VALUES (7, 'Math');
INSERT INTO Enroll (student_id, course_name) VALUES (7, 'Physics');
INSERT INTO Enroll (student_id, course_name) VALUES (7, 'Biology');
INSERT INTO Enroll (student_id, course_name) VALUES (8, 'Chemistry');
INSERT INTO Enroll (student_id, course_name) VALUES (8, 'Computer Science');
INSERT INTO Enroll (student_id, course_name) VALUES (9, 'Math');
INSERT INTO Enroll (student_id, course_name) VALUES (9, 'Physics');
INSERT INTO Enroll (student_id, course_name) VALUES (9, 'Biology');
INSERT INTO Enroll (student_id, course_name) VALUES (10, 'Chemistry');
INSERT INTO Enroll (student_id, course_name) VALUES (10, 'Computer Science');


-- Create a query to obtain the following: (Point 4)
-- a. Find student names for the first 10 students.
SELECT name FROM Student LIMIT 10;

-- b. Find students names whose native language is not Russian.
SELECT name FROM Student WHERE native_language != 'Russian';

-- c. Find student names of students who has specialization in “Robotics”.
SELECT name FROM Student WHERE id IN (SELECT student_id FROM takes WHERE specialization_name = 'Robotics');

-- d. Find pair of course names and students names if course credit is less than 3.
SELECT course_name, name FROM Enroll, Student WHERE course_name IN (SELECT name FROM Course WHERE credits < 3) AND student_id = id;

-- e. Find all course names where exist English native speaker
SELECT name FROM Course WHERE name IN (SELECT course_name FROM Enroll WHERE student_id IN (SELECT id FROM Student WHERE native_language = 'English'));