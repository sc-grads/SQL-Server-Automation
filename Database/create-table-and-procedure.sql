-- Use the Database
USE AutoTest;
GO

-- Create User Table
CREATE TABLE [dbo].[user] (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
    Surname NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE
);
GO

-- Create Stored Procedure to Insert Data
CREATE PROCEDURE InsertUser
    @Name NVARCHAR(50),
    @Surname NVARCHAR(50),
    @Email NVARCHAR(100)
AS
BEGIN
    INSERT INTO [dbo].[user] (Name, Surname, Email) 
    VALUES (@Name, @Surname, @Email);
END;
GO