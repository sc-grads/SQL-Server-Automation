
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'AutoTest_NM_27Mar')
    CREATE DATABASE AutoTest_NM_27Mar;
GO

USE AutoTest_NM_27Mar;
GO

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'user')
    CREATE TABLE [dbo].[user] (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Name NVARCHAR(100),
        Surname NVARCHAR(100),
        Email NVARCHAR(100)
    );
GO

IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'InsertUser')
    DROP PROCEDURE InsertUser;
GO
CREATE PROCEDURE InsertUser
    @Name NVARCHAR(100),
    @Surname NVARCHAR(100),
    @Email NVARCHAR(100)
AS
BEGIN
    INSERT INTO [dbo].[user] (Name, Surname, Email)
    VALUES (@Name, @Surname, @Email);
END;
GO

EXEC InsertUser 'Honney', 'Librinath', 'honney.librinath@example.com';
GO
EXEC InsertUser 'John', 'Doe', 'john.doe@example.com';
GO
EXEC InsertUser 'Jane', 'Smith', 'jane.smith@example.com';
GO