-- Stored Procedures (Sprocs)
-- File: C - Stored Procedures.sql

USE [A04-School]
GO
SELECT DB_NAME() AS 'Active Database'
GO

-- Take the following queries and turn them into stored procedures.

-- 1.   Selects the studentID's, CourseID and mark where the Mark is between 70 and 80
SELECT  StudentID, CourseId, Mark
FROM    Registration
WHERE   Mark BETWEEN 70 AND 80 -- BETWEEN is inclusive
--      Place this in a stored procedure that has two parameters,
--      one for the upper value and one for the lower value.
--      Call the stored procedure ListStudentMarksByRange

GO
DROP PROCEDURE IF EXISTS ListStudentMarksByRange
GO
CREATE PROCEDURE ListStudentMarksByRange
    @lower      decimal,
    @upper      decimal
AS
  SELECT  StudentID, CourseId, Mark
  FROM    Registration
  WHERE   Mark BETWEEN @lower AND @upper
    
RETURN
GO

---- Testing
--  Good inputs
EXEC ListStudentMarksByRange 70, 80
--  Bad inputs
EXEC ListStudentMarksByRange 80, 70
EXEC ListStudentMarksByRange 70, NULL
EXEC ListStudentMarksByRange NULL, 80
EXEC ListStudentMarksByRange NULL, NULL
EXEC ListStudentMarksByRange -5, 80
EXEC ListStudentMarksByRange 70, 101 -- Specifically checking the upper limit
/* ----------------------------------------------------- */

-- 2.   Selects the Staff full names and the Course ID's they teach.
SELECT  DISTINCT -- The DISTINCT keyword will remove duplate rows from the results
        FirstName + ' ' + LastName AS 'StaffFullName',
        CourseId
FROM    Staff S
    INNER JOIN Registration R
        ON S.StaffID = R.StaffID
ORDER BY StaffFullName, CourseId
--      Place this in a stored procedure called CourseInstructors.

GO
DROP PROCEDURE IF EXISTS CourseInstructors
GO
CREATE PROCEDURE CourseInstructors
    -- Parameters here
AS
    SELECT  DISTINCT -- The DISTINCT keyword will remove duplate rows from the results
        S.FirstName + ' ' + S.LastName AS 'Staff Full Name',
        CourseId
FROM    Staff AS S
    INNER JOIN Registration AS R
        ON S.StaffID = R.StaffID
ORDER BY 'Staff Full Name', CourseId
RETURN
GO

--EXEC CourseInstructors

/* ----------------------------------------------------- */

-- 3.   Selects the students first and last names who have last names starting with S.
SELECT  FirstName, LastName
FROM    Student
WHERE   LastName LIKE 'S%'
--      Place this in a stored procedure called FindStudentByLastName.
--      The parameter should be called @PartialName.
--      Do NOT assume that the '%' is part of the value in the parameter variable;
--      Your solution should concatenate the @PartialName with the wildcard.

GO
DROP PROCEDURE IF EXISTS Snames
GO
CREATE PROCEDURE Snames
    @PartialName varchar(35)
AS
    IF @PartialName IS NULL
    RAISERROR('Please Enter LastName', 16, 1)
    ELSE
    SELECT  FirstName, LastName
FROM    Student
WHERE  LastName LIKE @PartialName + '%'
RETURN
GO
--EXEC Snames S
--EXEC Snames L
--SELECT * FROM Student
/* ----------------------------------------------------- */

-- 4.   Selects the CourseID's and Coursenames where the CourseName contains the word 'programming'.
SELECT  CourseId, CourseName
FROM    Course
WHERE   CourseName LIKE '%programming%'
--      Place this in a stored procedure called FindCourse.
--      The parameter should be called @PartialName.
--      Do NOT assume that the '%' is part of the value in the parameter variable.

GO
DROP PROCEDURE IF EXISTS FindCourse
GO
CREATE PROCEDURE FindCourse
    @PartialName varchar(35)
AS
    SELECT  CourseId, CourseName
FROM    Course
WHERE   CourseName LIKE '%' + @PartialName + '%'
RETURN
GO

--EXEC FindCourse programming  

/* ----------------------------------------------------- */

-- 5.   Selects the Payment Type Description(s) that have the highest number of Payments made.
SELECT PaymentTypeDescription
FROM   Payment 
    INNER JOIN PaymentType 
        ON Payment.PaymentTypeID = PaymentType.PaymentTypeID
GROUP BY PaymentTypeDescription 
HAVING COUNT(PaymentType.PaymentTypeID) >= ALL (SELECT COUNT(PaymentTypeID)
                                                FROM Payment 
                                                GROUP BY PaymentTypeID)
--      Place this in a stored procedure called MostFrequentPaymentTypes.

GO
DROP PROCEDURE IF EXISTS MostFrequentPaymentTypes
GO
CREATE PROCEDURE MostFrequentPaymentTypes
    -- Parameters here
AS
    SELECT PaymentTypeDescription
FROM   Payment 
    INNER JOIN PaymentType 
        ON Payment.PaymentTypeID = PaymentType.PaymentTypeID
GROUP BY PaymentTypeDescription 
HAVING COUNT(PaymentType.PaymentTypeID) >= ALL (SELECT COUNT(PaymentTypeID)
                                                FROM Payment 
                                                GROUP BY PaymentTypeID)
RETURN
GO

/* ----------------------------------------------------- */

-- 6.   Selects the current staff members that are in a particular job position.
SELECT  FirstName + ' ' + LastName AS 'StaffFullName'
FROM    Position P
    INNER JOIN Staff S ON S.PositionID = P.PositionID
WHERE   DateReleased IS NULL
  AND   PositionDescription = 'Instructor'
--      Place this in a stored procedure called StaffByPosition

GO
DROP PROCEDURE IF EXISTS StaffByPosition 
GO
CREATE PROCEDURE StaffByPosition
    -- Parameters here
    @PartialName
AS
    SELECT  FirstName + ' ' + LastName AS 'StaffFullName'
FROM    Position P
    INNER JOIN Staff S ON S.PositionID = P.PositionID
WHERE   DateReleased IS NULL
  AND   PositionDescription = 'Instructor'
RETURN
GO

/* ----------------------------------------------------- */

-- 7.   Selects the staff members that have taught a particular course (e.g.: 'DMIT101').
SELECT  DISTINCT FirstName + ' ' + LastName AS 'StaffFullName',
        CourseId
FROM    Registration R
    INNER JOIN Staff S ON S.StaffID = R.StaffID
WHERE   DateReleased IS NULL
  AND   CourseId = 'DMIT101'
--      This select should also accommodate inputs with wildcards. (Change = to LIKE)
--      Place this in a stored procedure called StaffByCourseExperience

GO
DROP PROCEDURE IF EXISTS SprocName
GO
CREATE PROCEDURE SprocName
    -- Parameters here
AS
    -- Body of procedure here
RETURN
GO

