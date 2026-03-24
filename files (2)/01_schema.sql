-- ============================================================
--  CS27 - University Management System
--  File 1: Database and table creation
-- ============================================================

CREATE DATABASE IF NOT EXISTS university_db;
USE university_db;

-- ----------------------------
-- Table: Department
-- A department groups lecturers and courses together
-- ----------------------------
CREATE TABLE Department (
    dept_id     INT AUTO_INCREMENT PRIMARY KEY,
    dept_name   VARCHAR(100) NOT NULL UNIQUE,
    building    VARCHAR(50),
    created_at  DATE DEFAULT (CURRENT_DATE)
);

-- ----------------------------
-- Table: Lecturer
-- A lecturer belongs to one department
-- ----------------------------
CREATE TABLE Lecturer (
    lecturer_id   INT AUTO_INCREMENT PRIMARY KEY,
    first_name    VARCHAR(50) NOT NULL,
    last_name     VARCHAR(50) NOT NULL,
    email         VARCHAR(100) NOT NULL UNIQUE,
    phone         VARCHAR(20),
    dept_id       INT NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

-- ----------------------------
-- Table: Student
-- A student can enrol in multiple courses
-- ----------------------------
CREATE TABLE Student (
    student_id   INT AUTO_INCREMENT PRIMARY KEY,
    first_name   VARCHAR(50) NOT NULL,
    last_name    VARCHAR(50) NOT NULL,
    email        VARCHAR(100) NOT NULL UNIQUE,
    birth_date   DATE,
    enrol_year   YEAR NOT NULL
);

-- ----------------------------
-- Table: Course
-- A course is taught by one lecturer and belongs to one department
-- ----------------------------
CREATE TABLE Course (
    course_id    INT AUTO_INCREMENT PRIMARY KEY,
    course_code  VARCHAR(20) NOT NULL UNIQUE,
    course_name  VARCHAR(100) NOT NULL,
    credits      INT NOT NULL DEFAULT 3,
    lecturer_id  INT NOT NULL,
    dept_id      INT NOT NULL,
    FOREIGN KEY (lecturer_id) REFERENCES Lecturer(lecturer_id),
    FOREIGN KEY (dept_id)     REFERENCES Department(dept_id)
);

-- ----------------------------
-- Table: Enrolment (junction table — Student M:N Course)
-- Stores which student is enrolled in which course.
-- Grade is stored here because it depends on BOTH the student and the course.
-- ----------------------------
CREATE TABLE Enrolment (
    enrolment_id  INT AUTO_INCREMENT PRIMARY KEY,
    student_id    INT NOT NULL,
    course_id     INT NOT NULL,
    enrol_date    DATE NOT NULL DEFAULT (CURRENT_DATE),
    grade         DECIMAL(4,2),            -- grade out of 20, NULL if not yet evaluated
    UNIQUE (student_id, course_id),        -- a student cannot enrol in the same course twice
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
        ON DELETE CASCADE,                 -- deleting a student removes their enrolments too
    FOREIGN KEY (course_id)  REFERENCES Course(course_id)
        ON DELETE RESTRICT                 -- cannot delete a course that has enrolled students
);
