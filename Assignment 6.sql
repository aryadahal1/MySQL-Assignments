/* Q1 */
Select StaffID, Count(ClassID) 
from Faculty_Classes
group by StaffID;

/* Q2 */
 Select StudentID, Sum(Credits) 
 from Classes
 inner join Student_Schedules 
 on Classes.ClassID = Student_Schedules.ClassID 
 group by StudentID;
 
 /* Q3 */
 Select Count(MondaySchedule) + Count(TuesdaySchedule) + Count(WednesdaySchedule) + Count(ThursdaySchedule) + Count(FridaySchedule) 
 from Classes 
 where Hour(StartTime) < 12;
 
 /* Q4 */
Select  StudMajor, Count(StudentID) 
from Students 
group by StudMajor;

/* Q5 */
Select BuildingCode, Count(ClassID)
from Class_Rooms 
inner join Classes 
ON Class_Rooms.ClassRoomID = Classes.ClassRoomID
WHERE Hour(StartTime) > 12 and Hour(StartTime) < 4
Group by BuildingCode ;

/* Q6 */
SELECT DISTINCT Staff.StaffID, Position, Tenured From Staff
Inner Join Faculty
Where Position = 'Faculty' AND tenured = 1;

/* Q7 

SELECT Students.StudentID,
       CASE WHEN AVG(Grade) >= 60 THEN 'Student Passed' ELSE 'Student Failed' 
       END status
FROM Students INNER JOIN  Student_Schedules
ON Students.StudentID = Student_Schedules.StudentID
GROUP BY Students.StudentID; */

SELECT  StudentID, ClassID,
CASE 
WHEN Grade >= 60 then 'Student Passed' 
ELSE 'Student Failed'
END 
FROM Student_Schedules;

/* Q9 */
SELECT StudentID, StudMajor,
CASE 
WHEN (StudMajor = 6) > (StudMajor = 2) THEN 'Art Majority'
ELSE 'English Majority'
END
FROM Students
GROUP BY StudentID ;

/* Q 10*/
UPDATE Staff INNER JOIN Faculty ON Staff.StaffID = Faculty.StaffID
SET salary  = CASE
		WHEN Title = 'Professor' AND status = 'Full Time' THEN Salary*1.1
		WHEN Title = 'Associate Professor' THEN Salary*1.05
		WHEN Title = 'Instructor'  THEN Salary*1.03
		ELSE salary*1
	END
     ORDER BY Faculty.StaffID;
     
/* Q11 */
SELECT StudentID, Classes.ClassID,
       CASE WHEN Classes.StartTime > 6  <12 THEN 'Yes' ELSE 'No' 
       END status
FROM Classes INNER JOIN Student_Schedules
GROUP BY  StudentID,  ClassID; 
  
  /* Q12.1 */
  INSERT INTO  students (StudentID, StudFirstName, StudLastName, StudStreetAddress, StudCity, StudState, StudZipCode, StudAreaCode)
  VALUES (1020, 'Joe', 'Rock', '123 Main Street', 'Dallas', 'WA', 75032, 206);
   
   /* Q12.2 */
	UPDATE  Students
	SET StudPhoneNumber = '123-459'
	WHERE StudentID = 1020;

  /* Q12.3 */  
	UPDATE  Students
	SET StudState = 'TX'
	WHERE StudentID = 1020;
    
    
  
  
    
        
        
        