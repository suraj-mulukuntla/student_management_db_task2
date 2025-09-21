USE studentmanagement;


SHOW TABLES;


SELECT c.CourseID, c.CourseName, s.StudentID, s.Name, e.Grade
FROM courses c
JOIN enrollments e ON c.CourseID = e.CourseID
JOIN students s ON e.StudentID = s.StudentID
JOIN (
    SELECT CourseID, MAX(Grade) AS MaxGrade
    FROM enrollments
    GROUP BY CourseID
) m ON e.CourseID = m.CourseID AND e.Grade = m.MaxGrade
ORDER BY c.CourseID, s.StudentID;
  
  
  
  SELECT c.CourseID, c.CourseName,
       COUNT(*) AS Total_Students,
       SUM(CASE WHEN e.Grade >= 40 THEN 1 ELSE 0 END) AS Pass_Count,
       ROUND(100.0 * SUM(CASE WHEN e.Grade >= 40 THEN 1 ELSE 0 END) / COUNT(*), 2) AS Pass_Rate_Pct
FROM courses c
JOIN enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName;


SELECT s.StudentID, s.Name,
       ROUND(AVG(e.Grade), 2) AS Avg_Grade,
       COUNT(e.CourseID) AS Courses_Taken
FROM students s
JOIN enrollments e ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.Name
ORDER BY Avg_Grade DESC
LIMIT 1;


SELECT s.StudentID, s.Name,
       COUNT(DISTINCT e.CourseID) AS Num_Courses
FROM students s
JOIN enrollments e ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.Name
HAVING COUNT(DISTINCT e.CourseID) > 1;
