-- ============================================================
--  CS27 - University Management System
--  File 4: SELECT queries (Part 2.4)
-- ============================================================

USE university_db;

-- ----------------------------
-- 1. Retrieve all records from a table
-- ----------------------------
SELECT * FROM Student;

-- ----------------------------
-- 2. Specific columns with WHERE
-- Show name and email of students who enrolled in 2023
-- ----------------------------
SELECT first_name, last_name, email
FROM Student
WHERE enrol_year = 2023;

-- ----------------------------
-- 3. Sorted results with ORDER BY
-- List all courses sorted by number of credits (highest first)
-- ----------------------------
SELECT course_code, course_name, credits
FROM Course
ORDER BY credits DESC;

-- ----------------------------
-- 4. Limited results with LIMIT
-- Show only the first 5 students
-- ----------------------------
SELECT first_name, last_name, enrol_year
FROM Student
ORDER BY enrol_year
LIMIT 5;

-- ----------------------------
-- 5. Filtering with BETWEEN, LIKE, IN
-- ----------------------------

-- a) Enrolments with a grade between 12 and 16
SELECT student_id, course_id, grade
FROM Enrolment
WHERE grade BETWEEN 12 AND 16;

-- b) Lecturers whose last name starts with 'K'
SELECT first_name, last_name, email
FROM Lecturer
WHERE last_name LIKE 'K%';

-- c) Courses belonging to department 1 or 2
SELECT course_name, credits, dept_id
FROM Course
WHERE dept_id IN (1, 2);

-- ----------------------------
-- 6. INNER JOIN across two tables
-- Each enrolment with the student's name and the course name
-- ----------------------------
SELECT
    s.first_name,
    s.last_name,
    c.course_name,
    e.grade
FROM Enrolment e
INNER JOIN Student s ON e.student_id = s.student_id
INNER JOIN Course  c ON e.course_id  = c.course_id;

-- ----------------------------
-- 7. LEFT JOIN — and how it differs from INNER JOIN
-- Show ALL students, even those not enrolled in any course.
-- With INNER JOIN, students with no enrolments would not appear at all.
-- With LEFT JOIN, they appear with NULL in the course columns.
-- ----------------------------
SELECT
    s.first_name,
    s.last_name,
    c.course_name   -- will be NULL if the student has no enrolment
FROM Student s
LEFT JOIN Enrolment e ON s.student_id = e.student_id
LEFT JOIN Course    c ON e.course_id  = c.course_id;

-- ----------------------------
-- 8. JOIN across three or more tables
-- Student name + course + lecturer teaching that course
-- ----------------------------
SELECT
    s.first_name    AS student_first_name,
    s.last_name     AS student_last_name,
    c.course_name   AS course,
    l.first_name    AS lecturer_first_name,
    l.last_name     AS lecturer_last_name,
    e.grade         AS grade
FROM Enrolment e
INNER JOIN Student  s ON e.student_id  = s.student_id
INNER JOIN Course   c ON e.course_id   = c.course_id
INNER JOIN Lecturer l ON c.lecturer_id = l.lecturer_id;

-- ----------------------------
-- 9. IS NULL / IS NOT NULL
-- ----------------------------

-- a) Students who have not been graded yet
SELECT
    s.first_name,
    s.last_name,
    c.course_name
FROM Enrolment e
INNER JOIN Student s ON e.student_id = s.student_id
INNER JOIN Course  c ON e.course_id  = c.course_id
WHERE e.grade IS NULL;

-- b) Enrolments that already have a grade
SELECT student_id, course_id, grade
FROM Enrolment
WHERE grade IS NOT NULL;
