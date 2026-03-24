-- ============================================================
--  CS27 - University Management System
--  File 5: Aggregate functions & reporting (Part 3)
-- ============================================================

USE university_db;

-- ----------------------------
-- 1. COUNT — total number of students
-- ----------------------------
SELECT COUNT(*) AS total_students
FROM Student;

-- ----------------------------
-- 2. MAX and MIN of a numeric column
-- Highest and lowest grade recorded in the whole database
-- ----------------------------
SELECT
    MAX(grade) AS highest_grade,
    MIN(grade) AS lowest_grade
FROM Enrolment
WHERE grade IS NOT NULL;

-- ----------------------------
-- 3. AVG — overall average grade
-- ----------------------------
SELECT ROUND(AVG(grade), 2) AS overall_average
FROM Enrolment
WHERE grade IS NOT NULL;

-- ----------------------------
-- 4. GROUP BY with an aggregate function
-- Number of students enrolled in each course
-- ----------------------------
SELECT
    c.course_name,
    COUNT(e.student_id) AS enrolled_students
FROM Course c
LEFT JOIN Enrolment e ON c.course_id = e.course_id
GROUP BY c.course_name
ORDER BY enrolled_students DESC;

-- ----------------------------
-- 5. HAVING — filter grouped results
-- Show only courses where the average grade is below 15
-- ----------------------------
SELECT
    c.course_name,
    ROUND(AVG(e.grade), 2) AS course_average
FROM Enrolment e
INNER JOIN Course c ON e.course_id = c.course_id
WHERE e.grade IS NOT NULL
GROUP BY c.course_name
HAVING course_average < 15
ORDER BY course_average ASC;

-- ----------------------------
-- 6. Summary report: JOIN + GROUP BY + HAVING
-- For each department: number of courses, total enrolments, and average grade
-- Only show departments with at least 2 enrolments
-- ----------------------------
SELECT
    d.dept_name                       AS department,
    COUNT(DISTINCT c.course_id)       AS number_of_courses,
    COUNT(e.enrolment_id)             AS total_enrolments,
    ROUND(AVG(e.grade), 2)            AS average_grade
FROM Department d
INNER JOIN Course    c ON d.dept_id   = c.dept_id
LEFT  JOIN Enrolment e ON c.course_id = e.course_id
GROUP BY d.dept_name
HAVING total_enrolments >= 2
ORDER BY average_grade DESC;
