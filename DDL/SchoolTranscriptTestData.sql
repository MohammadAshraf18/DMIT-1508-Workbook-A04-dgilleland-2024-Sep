/*
    Database scripts execute within
    a certain context - a specific
    database.
    We can change the context through
    the USE statement.
*/
SELECT DB_NAME() AS 'Initial Database'
GO
-- Ensuring that I'm inside the correct database
USE [SchoolTranscript]
GO
SELECT DB_NAME() AS 'Active Database'
GO


-- Create a student (DML statement)
INSERT INTO Students(GivenName, Surname, DateOfBirth, Enrolled)
VALUES ('Sara', 'Bellum', 'Aug 1, 2005', 1)
INSERT INTO Students(GivenName, Surname, DateOfBirth, Enrolled)
VALUES  ('B', '4', 'Aug 20, 2025', 1)
-- Explore the results (Query statement)
SELECT * FROM Students
