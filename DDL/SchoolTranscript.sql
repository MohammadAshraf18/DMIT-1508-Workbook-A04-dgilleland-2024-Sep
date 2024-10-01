/* **********************************************
 * Simple Table Creation - Columns and Primary Keys
 *
 * School Transcript
 *  Version 1.0.0
 *
 * Author: Dan Gilleland
 ********************************************** */
-- Create the database
IF NOT EXISTS (SELECT name FROM master.sys.databases WHERE name = N'SchoolTranscript')
BEGIN
    CREATE DATABASE [SchoolTranscript]
END
GO

-- Switch execution context to the database
USE [SchoolTranscript] -- remaining SQL statements will run against the SchoolTranscript database
GO

-- Create Tables...
-- 1) Drop tables that already exist
--    Drop the table in the reverse order
--    that they were created
DROP TABLE IF EXISTS StudentCourses
DROP TABLE IF EXISTS Courses
DROP TABLE IF EXISTS Students

-- 2) Create the tables in the right order
--    Parent tables before child tables
-- The CREATE TABLE statement in SQL is used to
-- define the schema of a table. This is also
-- referred to as a table definition.
-- The CREATE TABLE statement has a comma-
-- separated list of column definitions.
CREATE TABLE Students
(
    StudentID       int
        -- Primary Key constraint ensures there are no duplicates
        -- and uses this column to uniquely identify a row of data
        CONSTRAINT PK_Student_StudentID
            PRIMARY KEY
        -- Assign the database the reponsibility to generate
        -- a value for this column (using the IDENTITY)
        IDENTITY(20250001, 3) -- The first student will have 20250001
                                    NOT NULL,
    GivenName       varchar(50)
        CONSTRAINT CK_Students_GivenName
            CHECK (GivenName LIKE '[A-Z][A-Z]%')
            -- Pattern Matching    \___/\___/\- % means zero or more characters
            --                      |- A single character ranging from A to Z
                                    NOT NULL,
    Surname         varchar(50)
        CONSTRAINT CK_Students_Surname
            CHECK (Surname LIKE '__%') -- Note the two underscores
            -- Pattern Matching: a single underscore _ means a single character
                                    NOT NULL,
    DateOfBirth     datetime
        CONSTRAINT CK_Students_DateOfBirth
            CHECK (DateOfBirth < GETDATE())
            -- Relational Comparison to the results of the GETDATE() function
                                    NOT NULL,
    Enrolled        bit
        CONSTRAINT DF_Students_Enrolled
            DEFAULT (1) -- If a value is not supplied for this column
                        -- during an INSERT, then the database server
                        -- will use this value as the default
                                    NOT NULL
)


CREATE TABLE Courses
(
    [Number]        varchar(10) -- cannot be used with IDENTITY
        CONSTRAINT PK_Courses_Number
            PRIMARY KEY
                                    NOT NULL,
    [Name]          varchar(50)     NOT NULL,
    Credits         decimal(3,1)    NOT NULL,
    [Hours]         tinyint         NOT NULL,
    Active          bit             NOT NULL,
    Cost            money           NOT NULL
)

CREATE TABLE StudentCourses
(
    StudentID       int
        CONSTRAINT FK_StudentCourses_StudentID
            FOREIGN KEY REFERENCES Students(StudentID)
                                    NOT NULL,
    CourseNumber    varchar(10)
        CONSTRAINT FK_StudentCourses_CourseNumber
            FOREIGN KEY REFERENCES Courses([Number])
                                    NOT NULL,
    [Year]          smallint        NOT NULL,
    Term            char(3)         NOT NULL,
    FinalMark       tinyint             NULL,
    [Status]        char(1)         NOT NULL,
    -- Table-level constraint for any constraints
    -- that involve more than one column/attribute
    CONSTRAINT PK_StudentCourses_StudentID_CourseNumber
        PRIMARY KEY (StudentID, CourseNumber)
)
