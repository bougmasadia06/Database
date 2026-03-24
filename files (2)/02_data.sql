-- ============================================================
--  CS27 - University Management System
--  File 2: Sample data insertion (10+ rows per table)
-- ============================================================

USE university_db;

-- ----------------------------
-- Departments (6 rows)
-- ----------------------------
INSERT INTO Department (dept_name, building) VALUES
('Computer Science',   'Block A'),
('Mathematics',        'Block B'),
('Physics',            'Block C'),
('Business Studies',   'Block D'),
('English Literature', 'Block E'),
('Civil Engineering',  'Block F');

-- ----------------------------
-- Lecturers (10 rows)
-- ----------------------------
INSERT INTO Lecturer (first_name, last_name, email, phone, dept_id) VALUES
('Kofi',    'Mensah',    'k.mensah@bit.bf',    '+226-70-001-001', 1),
('Amina',   'Ouedraogo', 'a.ouedraogo@bit.bf', '+226-70-001-002', 1),
('Jacques', 'Pale',      'j.pale@bit.bf',       '+226-70-001-003', 2),
('Fatima',  'Traore',    'f.traore@bit.bf',     '+226-70-001-004', 2),
('Ibrahim', 'Sawadogo',  'i.sawadogo@bit.bf',   '+226-70-001-005', 3),
('Mariam',  'Coulibaly', 'm.coulibaly@bit.bf',  '+226-70-001-006', 4),
('David',   'Kabore',    'd.kabore@bit.bf',     '+226-70-001-007', 4),
('Sylvie',  'Zongo',     's.zongo@bit.bf',      '+226-70-001-008', 5),
('Prosper', 'Nikiema',   'p.nikiema@bit.bf',    '+226-70-001-009', 6),
('Grace',   'Ilboudo',   'g.ilboudo@bit.bf',    '+226-70-001-010', 1);

-- ----------------------------
-- Students (12 rows)
-- ----------------------------
INSERT INTO Student (first_name, last_name, email, birth_date, enrol_year) VALUES
('Adama',     'Yameogo',    'adama.y@student.bit.bf',      '2003-04-12', 2023),
('Bintou',    'Kone',       'bintou.k@student.bit.bf',     '2002-07-25', 2022),
('Charles',   'Ouali',      'charles.o@student.bit.bf',    '2003-01-30', 2023),
('Diane',     'Balima',     'diane.b@student.bit.bf',      '2002-11-08', 2022),
('Ernest',    'Tapsoba',    'ernest.t@student.bit.bf',     '2004-03-17', 2024),
('Flore',     'Compaore',   'flore.c@student.bit.bf',      '2003-09-05', 2023),
('Gervais',   'Bambara',    'gervais.b@student.bit.bf',    '2002-06-22', 2022),
('Hawa',      'Diallo',     'hawa.d@student.bit.bf',       '2004-01-14', 2024),
('Isidore',   'Tiendrebeogo','isidore.t@student.bit.bf',   '2003-08-19', 2023),
('Josephine', 'Nacoulma',   'josephine.n@student.bit.bf',  '2002-12-02', 2022),
('Kevin',     'Bationo',    'kevin.b@student.bit.bf',      '2003-05-11', 2023),
('Laure',     'Soma',       'laure.s@student.bit.bf',      '2004-07-30', 2024);

-- ----------------------------
-- Courses (10 rows)
-- ----------------------------
INSERT INTO Course (course_code, course_name, credits, lecturer_id, dept_id) VALUES
('CS101',  'Introduction to Programming',      3, 1, 1),
('CS102',  'Data Structures and Algorithms',   4, 2, 1),
('CS103',  'The Relational Model & Databases', 3, 1, 1),
('CS104',  'Operating Systems',                3, 10, 1),
('MATH101','Calculus I',                       4, 3, 2),
('MATH102','Linear Algebra',                   3, 4, 2),
('PHY101', 'Mechanics',                        3, 5, 3),
('BUS101', 'Introduction to Management',       3, 6, 4),
('ENG101', 'Academic Writing',                 2, 8, 5),
('CIV101', 'Statics and Structures',           4, 9, 6);

-- ----------------------------
-- Enrolments (15 rows)
-- ----------------------------
INSERT INTO Enrolment (student_id, course_id, enrol_date, grade) VALUES
(1,  1,  '2023-09-05', 16.00),
(1,  3,  '2023-09-05', 14.50),
(1,  5,  '2023-09-05', 12.00),
(2,  1,  '2022-09-06', 18.00),
(2,  2,  '2022-09-06', 15.50),
(3,  3,  '2023-09-05', 11.00),
(3,  4,  '2023-09-05', 13.75),
(4,  6,  '2022-09-06', 17.00),
(5,  1,  '2024-09-04', NULL),   -- enrolled but not yet graded
(5,  5,  '2024-09-04', NULL),
(6,  2,  '2023-09-05',  9.00),
(7,  7,  '2022-09-06', 14.00),
(8,  8,  '2024-09-04', NULL),
(9,  3,  '2023-09-05', 16.50),
(10, 9,  '2022-09-06', 15.00);
