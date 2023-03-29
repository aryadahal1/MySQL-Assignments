/* Assignment5 */
/* Q1 */
SELECT Count(StudMajor) from Students S,majors M
WHERE S.StudMajor = M.MajorID AND M.Major = 'ART';

/* Q2 */
SELECT StaffID from Staff S
WHERE S.StaffID NOT IN (SELECT StaffID from faculty_classes);

/* Q3 */
SELECT ClassroomID from Class_Rooms CR,Buildings B
WHERE CR.BuildingCode = B.BuildingCode AND B.ElevatorAccess = 1;

/* Q4 */
SELECT StudentID from Students S
WHERE S.StudentID NOT IN (SELECT StudentID from Student_Schedules);

/* Q5 */
SELECT Student_Schedules.StudentID, CONCAT(StudFirstName,' ',StudLastName) AS StudFullName, Students.StudMajor, MAX(Student_Schedules.Grade) AS MaxGrade
From Student_Schedules
JOIN Students ON Students.StudentID = Student_Schedules.StudentID
GROUP BY Student_Schedules.StudentID, Students.StudMajor,StudFullName
HAVING MAX(Student_Schedules.Grade) = (SELECT MAX(Grade) FROM Student_Schedules);

/* Q6 */
SELECT DISTINCT  S.SubjectID, S.SubjectName, FS.StaffID
FROM Subjects S
INNER JOIN Faculty_Subjects FS ON S.SubjectID = FS.SubjectID
WHERE S.SubjectID = FS.SubjectID AND FS.ProficiencyRating = 10
ORDER BY SubjectID;

/* Q7 */
SELECT DISTINCT s.StudentID, s.StudMajor, ss.Grade, CONCAT (StudFirstName, ' ' , StudLastName) AS StudFullName
FROM Students s
JOIN Student_Schedules ss  ON s.StudentID = ss.StudentID
WHERE ss.Grade IN (SELECT MAX(Grade) FROM Students  GROUP BY  StudentID);

/* Q8 */
SELECT s.StudentID, s.StudFirstName, c.SubjectName, c.SubjectPreReq, c.SubjectID
FROM Students s
INNER JOIN Student_Schedules ss ON s.StudentID = ss.StudentID
INNER JOIN Classes cl  ON ss.ClassID= cl.ClassID
INNER JOIN Subjects c ON cl.SubjectID = c.SubjectID
WHERE SubjectPreReq IS NOT NULL;

/* Q9 */
SELECT s.SubjectID, s.SubjectName, CONCAT (StfFirstName, ' ', StfLastname) AS InstructorName, MIN(c.StartTime) AS EarliestStartTime
FROM Subjects s
INNER JOIN Classes c ON s.SubjectID = c.SubjectID
INNER JOIN Faculty_Classes fc ON c.ClassID = fc.ClassID
INNER JOIN Staff stf ON fc.StaffID = stf.StaffID
GROUP BY InstructorName, s.SubjectID;

/* Q10 */
/* Couldnt solve */
SELECT d.DeptChair, stf.StfFirstName, COUNT(s.SubjectID) AS NumClassesTaught
FROM Departments d
INNER JOIN Categories c ON d.DepartmentID =c.DepartmentID
INNER JOIN Faculty_Categories fc ON c.CategoryID = fc.CategoryID
INNER JOIN Staff stf ON fc.StaffID = stf.StaffID
INNER JOIN Faculty_Subjects fs ON stf.StaffID = fs.StaffID
INNER JOIN Subjects s ON fs.SubjectID = s.SubjectID
WHERE d.DeptChair  <> stf.StaffID
GROUP BY d.DeptChair, stf.StfFirstName
HAVING COUNT(s.SubjectID) = (SELECT MAX(NumClassesTaught)FROM (SELECT d.DeptChair, COUNT(s.SubjectID) AS NumClassesTaught
                                  FROM Departments d
                                 INNER JOIN Categories c ON d.DepartmentID =c.DepartmentID
									INNER JOIN Staff stf ON fc.StaffID = stf.StaffID
									INNER JOIN Faculty_Subjects fs ON stf.StaffID = fs.StaffID
									INNER JOIN Subjects s ON fs.SubjectID = s.SubjectID
                                  WHERE d.DeptChair <> stf.StaffID
                                  GROUP BY d.DeptChair) AS NumClassesPerDepartmentHead);
                            
