-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema college
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `college` ;

-- -----------------------------------------------------
-- Schema college
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `college` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `college` ;

-- -----------------------------------------------------
-- Table `college`.`college`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `college`.`college` ;

CREATE TABLE IF NOT EXISTS `college`.`college` (
  `college_id` INT NOT NULL AUTO_INCREMENT,
  `college` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`college_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `college`.`department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `college`.`department` ;

CREATE TABLE IF NOT EXISTS `college`.`department` (
  `department_id` INT NOT NULL AUTO_INCREMENT,
  `department` VARCHAR(100) NOT NULL,
  `college_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`department_id`),
  INDEX `college_id` (`college_id` ASC) VISIBLE,
  CONSTRAINT `department_ibfk_1`
    FOREIGN KEY (`college_id`)
    REFERENCES `college`.`college` (`college_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `college`.`course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `college`.`course` ;

CREATE TABLE IF NOT EXISTS `college`.`course` (
  `course_id` VARCHAR(10) NOT NULL,
  `course` VARCHAR(100) NOT NULL,
  `credits` INT NOT NULL,
  `department_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`course_id`),
  INDEX `department_id` (`department_id` ASC) VISIBLE,
  CONSTRAINT `course_ibfk_1`
    FOREIGN KEY (`department_id`)
    REFERENCES `college`.`department` (`department_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `college`.`student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `college`.`student` ;

CREATE TABLE IF NOT EXISTS `college`.`student` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NULL DEFAULT NULL,
  `last_name` VARCHAR(50) NULL DEFAULT NULL,
  `gender` CHAR(1) NULL DEFAULT NULL,
  `city` VARCHAR(50) NULL DEFAULT NULL,
  `state` CHAR(2) NULL DEFAULT NULL,
  `birthdate` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`student_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `college`.`faculty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `college`.`faculty` ;

CREATE TABLE IF NOT EXISTS `college`.`faculty` (
  `faculty_id` INT NOT NULL AUTO_INCREMENT,
  `faculty_fname` VARCHAR(50) NULL DEFAULT NULL,
  `faculty_lname` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`faculty_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `college`.`section`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `college`.`section` ;

CREATE TABLE IF NOT EXISTS `college`.`section` (
  `section_id` INT NOT NULL AUTO_INCREMENT,
  `course_id` VARCHAR(10) NULL DEFAULT NULL,
  `faculty_id` INT NULL DEFAULT NULL,
  `year` YEAR NULL DEFAULT NULL,
  `term` VARCHAR(10) NULL DEFAULT NULL,
  `section` INT NULL DEFAULT NULL,
  `capacity` INT NULL DEFAULT NULL,
  PRIMARY KEY (`section_id`),
  INDEX `course_id` (`course_id` ASC) VISIBLE,
  INDEX `faculty_id` (`faculty_id` ASC) VISIBLE,
  CONSTRAINT `section_ibfk_1`
    FOREIGN KEY (`course_id`)
    REFERENCES `college`.`course` (`course_id`),
  CONSTRAINT `section_ibfk_2`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `college`.`faculty` (`faculty_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `college`.`enrollment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `college`.`enrollment` ;

CREATE TABLE IF NOT EXISTS `college`.`enrollment` (
  `student_id` INT NOT NULL,
  `section_id` INT NOT NULL,
  PRIMARY KEY (`student_id`, `section_id`),
  INDEX `section_id` (`section_id` ASC) VISIBLE,
  CONSTRAINT `enrollment_ibfk_1`
    FOREIGN KEY (`student_id`)
    REFERENCES `college`.`student` (`student_id`),
  CONSTRAINT `enrollment_ibfk_2`
    FOREIGN KEY (`section_id`)
    REFERENCES `college`.`section` (`section_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Insert tables
INSERT INTO College (college_id, college) VALUES
(1, 'College of Physical Science and Engineering'),
(2, 'College of Business and Communication'),
(3, 'College of Language and Letters');

INSERT INTO Department (department_id, department, college_id) VALUES
(1, 'Computer Information Technology', 1),
(2, 'Economics', 2),
(3, 'Humanities and Philosophy', 3);

INSERT INTO Course (course_id, course, credits, department_id) VALUES
('CIT 111', 'Intro to Databases', 3, 1),
('ECON 388', 'Econometrics', 4, 2),
('ECON 150', 'Micro Economics', 3, 2),
('HUM 376', 'Classical Heritage', 2, 3);

INSERT INTO Faculty (faculty_id, faculty_fname, faculty_lname) VALUES
(1, 'Marty', 'Morring'),
(2, 'Nate', 'Nathan'),
(3, 'Ben', 'Barrus'),
(4, 'John', 'Jensen'),
(5, 'Bill', 'Barney');

INSERT INTO Section (section_id, course_id, faculty_id, year, term, section, capacity) VALUES
(1, 'CIT 111', 1, 2019, 'Fall', 1, 30),
(2, 'ECON 150', 2, 2019, 'Fall', 1, 50),
(3, 'ECON 150', 2, 2019, 'Fall', 2, 50),
(4, 'ECON 388', 3, 2019, 'Fall', 1, 35),
(5, 'HUM 376', 4, 2019, 'Fall', 1, 30),
(6, 'CIT 111', 1, 2018, 'Winter', 2, 30),
(7, 'CIT 111', 5, 2018, 'Winter', 3, 35),
(8, 'ECON 150', 2, 2018, 'Winter', 1, 50),
(9, 'ECON 150', 2, 2018, 'Winter', 2, 50),
(10, 'HUM 376', 4, 2018, 'Winter', 1, 30);

INSERT INTO Student (student_id, first_name, last_name, gender, city, state, birthdate) VALUES
(1, 'Paul', 'Miller', 'M', 'Dallas', 'TX', '1996-02-22'),
(2, 'Katie', 'Smith', 'F', 'Provo', 'UT', '1995-07-22'),
(3, 'Kelly', 'Jones', 'F', 'Provo', 'UT', '1998-06-22'),
(4, 'Devon', 'Merrill', 'M', 'Mesa', 'AZ', '2000-07-22'),
(5, 'Mandy', 'Murdock', 'F', 'Topeka', 'KS', '1996-11-22'),
(6, 'Alece', 'Adams', 'F', 'Rigby', 'ID', '1997-05-22'),
(7, 'Bryce', 'Carlson', 'M', 'Bozeman', 'MT', '1997-11-22'),
(8, 'Preston', 'Larsen', 'M', 'Decatur', 'TN', '1996-09-22'),
(9, 'Julia', 'Madsen', 'F', 'Rexburg', 'ID', '1998-09-22'),
(10, 'Susan', 'Sorensen', 'F', 'Mesa', 'AZ', '1998-08-09');

INSERT INTO Enrollment (student_id, section_id) VALUES
(6, 7),   -- Alece CIT 111 Winter 2018
(7, 6),   -- Bryce CIT 111 Winter 2018
(7, 8),   -- Bryce ECON 150 Winter 2018
(7, 10),  -- Bryce HUM 376 Winter 2018
(4, 5),   -- Devon HUM 376 Fall 2019
(9, 9),   -- Julia ECON 150 Winter 2018
(2, 4),   -- Katie ECON 388 Fall 2019
(3, 4),   -- Kelly ECON 388 Fall 2019
(5, 4),   -- Mandy ECON 388 Fall 2019
(5, 5),   -- Mandy HUM 376 Fall 2019
(1, 1),   -- Paul CIT 111 Fall 2019
(1, 3),   -- Paul ECON 150 Fall 2019
(8, 9),   -- Preston ECON 150 Winter 2018 
(10, 6);  -- Susan CIT 111 Winter 2018
-- Query 1
SELECT first_name AS 'fname', last_name AS 'lname', 
DATE_FORMAT(birthdate, '%M %d, %Y') AS 'Sept Birthdays'
FROM student
WHERE MONTH(birthdate) = 9
ORDER BY last_name;

-- Query 2
SELECT 
    last_name AS 'lname', first_name AS 'fname',
    FLOOR(DATEDIFF('2017-01-05', birthdate) / 365) AS Years,
    MOD(DATEDIFF('2017-01-05', birthdate), 365) AS Days,
    CONCAT(
        FLOOR(DATEDIFF('2017-01-05', birthdate) / 365), 
        ' years and ', 
        MOD(DATEDIFF('2017-01-05', birthdate), 365), 
        ' days'
    ) AS 'Years and Days'
FROM student
ORDER BY DATEDIFF('2017-01-05', birthdate) DESC;
    
-- Query 3
SELECT s.first_name AS fname, s.last_name AS lname
FROM faculty f
JOIN section sec ON f.faculty_id = sec.faculty_id
JOIN enrollment e ON sec.section_id = e.section_id
JOIN student s ON e.student_id = s.student_id
WHERE f.faculty_fname = 'John' AND f.faculty_lname = 'Jensen'
ORDER BY s.last_name;

-- Query 4
SELECT DISTINCT f.faculty_fname AS fname, f.faculty_lname AS lname
FROM student s
JOIN enrollment e ON s.student_id = e.student_id
JOIN section sec ON e.section_id = sec.section_id
JOIN faculty f ON sec.faculty_id = f.faculty_id
WHERE 
    s.first_name = 'Bryce' 
    AND sec.term = 'Winter'
    AND sec.year = 2018
ORDER BY f.faculty_lname;

-- Query 5
SELECT s.first_name AS fname, s.last_name AS lname
FROM course c
JOIN section sec ON c.course_id = sec.course_id
JOIN enrollment e ON sec.section_id = e.section_id
JOIN student s ON e.student_id = s.student_id
WHERE c.course = 'Econometrics'
	AND sec.term = 'Fall'
    AND sec.year = 2019
ORDER BY s.last_name;

-- Query 6
SELECT c.course AS 'name'
FROM student s
JOIN enrollment e ON s.student_id = e.student_id
JOIN section sec ON e.section_id = sec.section_id
JOIN course c ON sec.course_id = c.course_id
WHERE s.first_name = 'Bryce' 
    AND s.last_name = 'Carlson'
    AND sec.term = 'Winter'
    AND sec.year = 2018
ORDER BY 'name' ASC;

-- Query 7
SELECT sec.term, sec.year,
    COUNT(*) AS Enrollment
FROM enrollment e
JOIN section sec ON e.section_id = sec.section_id
WHERE sec.term = 'Fall' 
    AND sec.year = 2019
GROUP BY sec.term, sec.year;

-- Query 8
SELECT col.college AS Colleges,
    COUNT(*) AS Courses
FROM college col
JOIN department dep ON col.college_id = dep.college_id
JOIN course co ON dep.department_id = co.department_id
GROUP BY col.college
ORDER BY col.college;

-- Query 9
SELECT f.faculty_fname AS 'fname',  f.faculty_lname as 'lname',
    SUM(sec.capacity) AS TeachingCapacity
FROM faculty f
JOIN section sec ON f.faculty_id = sec.faculty_id
WHERE sec.term = 'Winter' 
    AND sec.year = 2018
GROUP BY f.faculty_id
ORDER BY TeachingCapacity ASC;

-- Query 10
SELECT s.last_name AS lname, s.first_name AS fname,
    SUM(c.credits) AS Credits
FROM student s
JOIN enrollment e ON s.student_id = e.student_id
JOIN section sec ON e.section_id = sec.section_id
JOIN course c ON sec.course_id = c.course_id
WHERE sec.term = 'Fall' 
    AND sec.year = 2019
GROUP BY s.student_id
HAVING Credits > 3
ORDER BY Credits DESC;










