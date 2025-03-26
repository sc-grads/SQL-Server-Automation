-- Create Database
CREATE DATABASE AutoTest;
GO

-- Use the Database
USE AutoTest;
GO

-- Create SQL Server User "Auto_user" with Full Access
CREATE LOGIN Auto_user WITH PASSWORD = 'SecurePass2025';
CREATE USER Auto_user FOR LOGIN Auto_user;
ALTER SERVER ROLE sysadmin ADD MEMBER Auto_user;
GO
