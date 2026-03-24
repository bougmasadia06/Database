-- ============================================================
--  CS27 - University Management System
--  File 3: UPDATE, DELETE & referential integrity
-- ============================================================

USE university_db;

-- ----------------------------
-- UPDATE (4 examples)
-- ----------------------------

-- 1. Fix a student's grade (typo in the original entry)
UPDATE Enrolment
SET grade = 17.50
WHERE student_id = 1 AND course_id = 1;

-- 2. Update a lecturer's phone number
UPDATE Lecturer
SET phone = '+226-70-999-001'
WHERE lecturer_id = 3;

-- 3. Update the building for a department
UPDATE Department
SET building = 'Block A2'
WHERE dept_name = 'Computer Science';

-- 4. Add a grade for a student who had none yet
UPDATE Enrolment
SET grade = 13.00
WHERE student_id = 5 AND course_id = 1;

-- ----------------------------
-- DELETE (2 examples)
-- ----------------------------

-- 1. Remove a single enrolment (student drops a course)
DELETE FROM Enrolment
WHERE student_id = 6 AND course_id = 2;

-- 2. Delete a student entirely.
--    Thanks to ON DELETE CASCADE, all their enrolments in the
--    Enrolment table are automatically deleted too.
DELETE FROM Student
WHERE student_id = 12;  -- Laure Soma

-- ----------------------------
-- Referential integrity — what happens when you break the rules
-- ----------------------------

-- Attempt 1: insert an enrolment for a student that does not exist (id = 999)
-- MySQL will throw: Cannot add or update a child row: a foreign key constraint fails
-- INSERT INTO Enrolment (student_id, course_id, enrol_date)
-- VALUES (999, 1, '2024-09-04');

-- Attempt 2: delete a course that still has enrolled students
-- MySQL blocks this because we used ON DELETE RESTRICT on course_id
-- DELETE FROM Course WHERE course_id = 1;

-- Both lines are commented out on purpose.
-- They demonstrate that MySQL enforces data integrity automatically.
