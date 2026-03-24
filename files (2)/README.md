# CS27 – University Management System
**Burkina Institute of Technology — Computer Science Department**
Course: The Relational Model & Databases | Instructor: Kweyakie Afi Blebo

---

## Group Members
- BOUGMA Sadiata
- KABORE Awa
- ZONGO Pascal
- WANGRE Delwendé Esther
- KAFANDO Dan Ernest Patrice
- SAWADOGO Sandrine

---

## Chosen Scenario: University Management System

We modeled a university's core operations: students, lecturers, courses, enrolments, and grades. The goal is to track which student takes which course, with which lecturer, and what grade they received.

---

## File Structure

```
university_db/
├── 01_schema.sql         → Database and table creation
├── 02_data.sql           → Sample data (10+ rows per table)
├── 03_update_delete.sql  → UPDATE, DELETE + referential integrity tests
├── 04_select_queries.sql → All SELECT queries (Part 2.4)
├── 05_aggregates.sql     → Aggregate functions and summary report (Part 3)
└── README.md             → This file
```

---

## Entities (Part 1.1)

We have 5 main entities.

### 1. Department
Represents a university department (e.g. Computer Science, Mathematics).

| Attribute | Type | Notes |
|-----------|------|-------|
| dept_id | INT (PK) | Auto-incremented — simple and avoids manual errors |
| dept_name | VARCHAR(100) UNIQUE | No two departments can share the same name |
| building | VARCHAR(50) | Physical location on campus |
| created_at | DATE | Creation date |

### 2. Lecturer
A lecturer belongs to one department and can teach multiple courses.

| Attribute | Type | Notes |
|-----------|------|-------|
| lecturer_id | INT (PK) | Auto-incremented primary key |
| first_name / last_name | VARCHAR(50) | Split for easier sorting and filtering |
| email | VARCHAR(100) UNIQUE | Each lecturer has a unique professional email |
| phone | VARCHAR(20) | Contact number |
| dept_id | INT (FK) | Links to Department |

### 3. Student
A student can enrol in multiple courses.

| Attribute | Type | Notes |
|-----------|------|-------|
| student_id | INT (PK) | Auto-incremented primary key |
| first_name / last_name | VARCHAR(50) | Split for easier sorting |
| email | VARCHAR(100) UNIQUE | Each student has a unique email |
| birth_date | DATE | Date of birth |
| enrol_year | YEAR | Year of admission |

### 4. Course
A course is taught by one lecturer and belongs to one department.

| Attribute | Type | Notes |
|-----------|------|-------|
| course_id | INT (PK) | Auto-incremented primary key |
| course_code | VARCHAR(20) UNIQUE | Short code like CS101 — must be unique |
| course_name | VARCHAR(100) | Full course title |
| credits | INT DEFAULT 3 | Credit value — defaults to 3 |
| lecturer_id | INT (FK) | The lecturer teaching this course |
| dept_id | INT (FK) | The department this course belongs to |

### 5. Enrolment (junction table)
Represents a student registering for a course. The grade is stored here because it depends on both the student and the course together.

| Attribute | Type | Notes |
|-----------|------|-------|
| enrolment_id | INT (PK) | Auto-incremented primary key |
| student_id | INT (FK) | The enrolled student |
| course_id | INT (FK) | The course being taken |
| enrol_date | DATE | Date of registration |
| grade | DECIMAL(4,2) | Grade out of 20 — NULL if not yet evaluated |

---

## Relationships (Part 1.2)

| Relationship | Type | Explanation | Foreign Key Location |
|---|---|---|---|
| Lecturer → Department | M:1 | Many lecturers can work in the same department | `dept_id` in Lecturer |
| Course → Lecturer | M:1 | One lecturer can teach many courses | `lecturer_id` in Course |
| Course → Department | M:1 | Many courses can belong to the same department | `dept_id` in Course |
| Student ↔ Course (via Enrolment) | M:N | A student takes many courses; a course has many students | `student_id` and `course_id` in Enrolment |

---

## Schema Diagram (Part 1.3)

```
Department
-----------
dept_id (PK)
dept_name
building
created_at
    |
    | 1:M
    |
Lecturer                      Course
-----------                   ----------
lecturer_id (PK)              course_id (PK)
first_name                    course_code
last_name                     course_name
email                         credits
phone                         lecturer_id (FK) -------> Lecturer
dept_id (FK) ---> Department  dept_id (FK) ----------> Department
                                  |
                                  | 1:M
                                  |
Student                       Enrolment
-----------                   ----------
student_id (PK) <------------ student_id (FK)
first_name                    course_id (FK) ---------> Course
last_name                     enrolment_id (PK)
email                         enrol_date
birth_date                    grade
enrol_year
```

> You can also paste the SQL schema into [dbdiagram.io](https://dbdiagram.io) to get a clean visual diagram.

---

## Normalization (Part 1.4)

### Starting point — one big unnormalized table

Imagine we put everything in a single flat table at first:

```
UniversityData(
  student_id, student_name, student_email,
  course_code, course_name, credits,
  lecturer_name, lecturer_email,
  dept_name, building,
  enrol_date, grade
)
```

**Sample rows:**

| student_id | student_name | course_code | course_name | credits | lecturer_name | dept_name | grade |
|---|---|---|---|---|---|---|---|
| 1 | Adama Yameogo | CS101 | Intro to Programming | 3 | Kofi Mensah | Computer Science | 16 |
| 1 | Adama Yameogo | CS103 | Databases | 3 | Kofi Mensah | Computer Science | 14.5 |
| 2 | Bintou Kone | CS101 | Intro to Programming | 3 | Kofi Mensah | Computer Science | 18 |

---

### First Normal Form (1NF)
**Rule:** every cell must hold a single atomic value, and every row must be unique.

**Problem:** `student_name` combines first and last name in one column — you cannot sort by last name easily.

**Fix:** split into `first_name` and `last_name`.

---

### Second Normal Form (2NF)
**Rule:** every non-key attribute must depend on the whole primary key, not just part of it.

**Problem:** if the primary key is `(student_id, course_code)`, then `course_name` and `credits` only depend on `course_code`, not on the student. Same with `student_email`, which only depends on `student_id`.

**Fix:** move course details into a `Course` table and student details into a `Student` table. Keep `Enrolment` for what depends on both (grade and enrolment date).

---

### Third Normal Form (3NF)
**Rule:** no non-key attribute should depend on another non-key attribute (no transitive dependencies).

**Problem:** `building` depends on `dept_name`, not on the course directly. And `lecturer_email` depends on `lecturer_name`, not on the course.

**Fix:** move `Department` and `Lecturer` into their own separate tables.

---

### Final normalized schema
5 clean tables: `Department`, `Lecturer`, `Student`, `Course`, `Enrolment` — each with one clear responsibility and no repeated data.

**Before:** Kofi Mensah's name and email appears on every row for every CS course.

**After:** Kofi Mensah appears once in `Lecturer`. If his email changes, we update it in one place only.

---

## How to Run the Project

Make sure MySQL 8+ is installed, then run the files in order:

```sql
SOURCE 01_schema.sql;
SOURCE 02_data.sql;
SOURCE 03_update_delete.sql;
SOURCE 04_select_queries.sql;
SOURCE 05_aggregates.sql;
```

Or from the command line:

```bash
mysql -u root -p < 01_schema.sql
mysql -u root -p university_db < 02_data.sql
mysql -u root -p university_db < 03_update_delete.sql
mysql -u root -p university_db < 04_select_queries.sql
mysql -u root -p university_db < 05_aggregates.sql
```

---

## Key Design Decisions

- **AUTO_INCREMENT** on all primary keys — avoids manual ID errors.
- **grade is NULL by default** in Enrolment — a student can be registered without a grade yet.
- **ON DELETE CASCADE** on `student_id` in Enrolment — deleting a student automatically removes their enrolments.
- **ON DELETE RESTRICT** on `course_id` in Enrolment — you cannot delete a course while students are still enrolled in it.
- **UNIQUE(student_id, course_id)** in Enrolment — prevents a student from enrolling in the same course twice.

---

*CS27 — Burkina Institute of Technology | 2025–2026*
