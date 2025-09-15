DROP DATABASE studentmanagement;
CREATE DATABASE StudentManagement;
USE StudentManagement;
CREATE TABLE Students (
  StudentID     INT AUTO_INCREMENT PRIMARY KEY,
  Name          VARCHAR(100) NOT NULL,
  Gender        ENUM('M','F','Other') NOT NULL,
  Age           TINYINT UNSIGNED NOT NULL,    
  Grade         VARCHAR(20) NOT NULL,          
  MathsScore    TINYINT UNSIGNED NOT NULL,
  ScienceScore  TINYINT UNSIGNED NOT NULL,
  EnglishScore  TINYINT UNSIGNED NOT NULL,
  CHECK (MathsScore   BETWEEN 0 AND 100),
  CHECK (ScienceScore BETWEEN 0 AND 100),
  CHECK (EnglishScore BETWEEN 0 AND 100)
) ENGINE=InnoDB;

INSERT INTO Students (Name, Gender, Age, Grade, MathsScore, ScienceScore, EnglishScore) VALUES
('Aarav',   'M', 15, 'Grade 10', 92, 88, 81),
('Isha',    'F', 15, 'Grade 10', 78, 85, 90),
('Kabir',   'M', 15, 'Grade 10', 66, 72, 80),
('Meera',   'F', 14, 'Grade 9',  95, 91, 87),
('Dev',     'M', 16, 'Grade 11', 59, 62, 70),
('Riya',    'F', 14, 'Grade 9',  88, 90, 85),
('Arjun',   'M', 15, 'Grade 10', 74, 68, 72),
('Sneha',   'F', 16, 'Grade 11', 81, 79, 84),
('Vikram',  'M', 15, 'Grade 10', 69, 75, 71),
('Ananya',  'F', 14, 'Grade 9',  93, 95, 89);

SELECT * FROM Students;

SELECT 
  AVG(MathsScore)   AS Avg_Maths,
  AVG(ScienceScore) AS Avg_Science,
  AVG(EnglishScore) AS Avg_English
FROM Students;


SELECT 
  Name, Grade,
  (MathsScore + ScienceScore + EnglishScore) AS TotalMarks
FROM Students
ORDER BY TotalMarks DESC
LIMIT 1;


SELECT 
  Grade, 
  COUNT(*) AS StudentCount
FROM Students
GROUP BY Grade;




SELECT 
  StudentID, Name, Grade, MathsScore, ScienceScore, EnglishScore
FROM Students
WHERE MathsScore > 80;


UPDATE Students
SET MathsScore = 85
WHERE StudentID = 3;


TASK-2 


CREATE TABLE IF NOT EXISTS Courses (
  CourseID INT AUTO_INCREMENT PRIMARY KEY,
  CourseName VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Enrollments (
  StudentID INT NOT NULL,
  CourseID INT NOT NULL,
  Grade TINYINT UNSIGNED NOT NULL,
  CHECK (Grade BETWEEN 0 AND 100),
  PRIMARY KEY (StudentID, CourseID),
  FOREIGN KEY (StudentID) REFERENCES Students(StudentID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (CourseID)  REFERENCES Courses(CourseID)  ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;



INSERT INTO Courses (CourseID, CourseName) VALUES
 (1, 'Mathematics'),
 (2, 'Science'),
 (3, 'English')
ON DUPLICATE KEY UPDATE CourseName = VALUES(CourseName);

INSERT INTO Enrollments VALUES (1, 1, 92), (1, 2, 88), (1, 3, 81);
INSERT INTO Enrollments VALUES (2, 1, 78), (2, 2, 85), (2, 3, 90);
INSERT INTO Enrollments VALUES (3, 1, 66), (3, 2, 72), (3, 3, 80);
INSERT INTO Enrollments VALUES (4, 1, 95), (4, 2, 91), (4, 3, 87);
INSERT INTO Enrollments VALUES (5, 1, 59), (5, 2, 62), (5, 3, 70);
INSERT INTO Enrollments VALUES (6, 1, 88), (6, 2, 90), (6, 3, 85);
INSERT INTO Enrollments VALUES (7, 1, 74), (7, 2, 68), (7, 3, 72);
INSERT INTO Enrollments VALUES (8, 1, 81), (8, 2, 79), (8, 3, 84);
INSERT INTO Enrollments VALUES (9, 1, 69), (9, 2, 75), (9, 3, 71);
INSERT INTO Enrollments VALUES (10, 1, 93), (10, 2, 95), (10, 3, 89);


SELECT
  c.CourseName,
  s.StudentID,
  s.Name,
  e.Grade
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
JOIN Courses c  ON e.CourseID  = c.CourseID
ORDER BY c.CourseName, e.Grade DESC, s.Name;


SELECT
  c.CourseName,
  ROUND(AVG(e.Grade),2) AS AverageGrade,
  COUNT(*) AS NumEnrolled
FROM Enrollments e
JOIN Courses c ON e.CourseID = c.CourseID
GROUP BY c.CourseName
ORDER BY AverageGrade DESC;


SELECT
  s.StudentID,
  s.Name,
  ROUND(AVG(e.Grade),2) AS AvgGrade
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
GROUP BY s.StudentID, s.Name
ORDER BY AvgGrade DESC
LIMIT 3;



SELECT COUNT(DISTINCT StudentID) AS StudentsWithAtLeastOneFail
FROM Enrollments
WHERE Grade < 40;
