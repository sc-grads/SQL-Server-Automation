BEGIN TRY
    IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'AutoTest_MN_02April')
        CREATE DATABASE AutoTest_MN_02April;
    PRINT 'Database AutoTest_MN_02April created successfully or already exists.';
END TRY
BEGIN CATCH
    PRINT 'Error creating database: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO

BEGIN TRY
    USE AutoTest_MN_02April;
    PRINT 'Switched to AutoTest_MN_02April database.';
END TRY
BEGIN CATCH
    PRINT 'Error switching to database: ' + ERROR_MESSAGE();
    THROW;
END CATCH;

BEGIN TRY
    IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'user')
        CREATE TABLE [dbo].[user] (
            ID INT IDENTITY(1,1) PRIMARY KEY,
            Name NVARCHAR(100),
            Surname NVARCHAR(100),
            Email NVARCHAR(100)
        );
    PRINT 'Table [dbo].[user] created successfully or already exists.';
END TRY
BEGIN CATCH
    PRINT 'Error creating table: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO

BEGIN TRY
    IF EXISTS (SELECT * FROM sys.procedures WHERE name = 'InsertUser')
        DROP PROCEDURE InsertUser;
    CREATE PROCEDURE InsertUser
        @Name NVARCHAR(100),
        @Surname NVARCHAR(100),
        @Email NVARCHAR(100)
    AS
    BEGIN
        INSERT INTO [dbo].[user] (Name, Surname, Email)
        VALUES (@Name, @Surname, @Email);
    END;
    PRINT 'Stored procedure InsertUser created successfully.';
END TRY
BEGIN CATCH
    PRINT 'Error creating stored procedure: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO

BEGIN TRY
    EXEC InsertUser 'Honney', 'Librinath', 'honney.librinath@example.com';
    PRINT 'Inserted user Honney Librinath successfully.';
END TRY
BEGIN CATCH
    PRINT 'Error inserting user Honney Librinath: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO

BEGIN TRY
    EXEC InsertUser 'John', 'Doe', 'john.doe@example.com';
    PRINT 'Inserted user John Doe successfully.';
END TRY
BEGIN CATCH
    PRINT 'Error inserting user John Doe: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO

BEGIN TRY
    EXEC InsertUser 'Jane', 'Smith', 'jane.smith@example.com';
    PRINT 'Inserted user Jane Smith successfully.';
END TRY
BEGIN CATCH
    PRINT 'Error inserting user Jane Smith: ' + ERROR_MESSAGE();
    THROW;
END CATCH;
GO