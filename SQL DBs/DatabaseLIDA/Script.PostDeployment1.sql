/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

--IF NOT EXISTS (SELECT [name]
-- FROM [sys].[database_principals]
-- WHERE [name] = N'$(aadGroupName)')
--BEGIN
-- CREATE USER [$(aadGroupName)] WITH DEFAULT_SCHEMA=[dbo];
-- ALTER ROLE db_datawriter ADD MEMBER [$(aadGroupName)];
--END

--exec sp_addrolemember  'db_owner', [$(DataFactoryName)]
Select 1;
--IF NOT EXISTS (SELECT TOP 1 name from DATransactions.sys.database_principals 
--				WHERE type_desc = 'EXTERNAL_USER' and name = '$(DataFactoryName)')
--BEGIN
--	CREATE USER [$(DataFactoryName)] FROM EXTERNAL PROVIDER;
--END

--GRANT CONTROL ON DATABASE::DATransactions TO [$(DataFactoryName)];