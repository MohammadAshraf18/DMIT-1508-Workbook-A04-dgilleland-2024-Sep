/*  TEST DATA
    Having test data that we can insert into our database tables
    will help us to ensure that our CREATE TABLE and ALTER TABLE statements
    are running correctly.
*/

-- Database scripts execute within a certain context - a specific database.
SELECT DB_NAME() AS 'Initial Database'  -- should be [master] when first executed
GO
-- We can change the context through the USE statement,ensuring that we're inside the correct database
USE [SchoolTranscript]  -- Switch to the desired database
GO
SELECT DB_NAME() AS 'Active Database'   -- shows that we are in the correct database
GO


/*=== Start of Test Data ===*/

-- Add a single student (DML statement)
INSERT INTO Students(GivenName, Surname, DateOfBirth, Enrolled)
VALUES  ('Sara', 'Bellum', 'Aug 1, 2005', 1)

-- Add multiple students (with default constraints)
INSERT INTO Students(GivenName, Surname, DateOfBirth)
VALUES  ('Oliver', 'Nerr', ''), -- O. Nerr
        ('Stewart', 'Dent', ''), -- Stew Dent
        ('Yu', 'Sur', ''),
        ('Anne', 'Nother', ''),
        ('Dee', 'Vellop-Ur', '')

/*
-- Add these students after altering the table constraints
INSERT INTO Students(GivenName, MiddleNames, Surname, DateOfBirth)
VALUES  ('Reginald', 'Ian', 'Stirr', '') -- Reg I. Stirr
*/

-- Explore the results (Query statement)
SELECT * FROM Students


/*
-- Samples of "bad" data (violates CHECK constraints)
INSERT INTO Students(GivenName, Surname, DateOfBirth, Enrolled)
VALUES  ('B', '4', 'Aug 20, 2025', 1)
*/
