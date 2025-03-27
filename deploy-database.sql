IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'AutoDBMuzuvukile')
    CREATE DATABASE AutoDBMuzuvukile;
GO

USE AutoDBMuzuvukile;
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

EXEC InsertUser 'Muzuvukile', 'User1', 'muzuvukile.user1@example.com';
GO
EXEC InsertUser 'Another', 'User2', 'another.user2@example.com';
GO