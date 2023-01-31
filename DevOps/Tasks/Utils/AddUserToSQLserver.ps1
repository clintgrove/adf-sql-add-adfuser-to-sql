param (
    [String] $db_server = "sqlsrv-dwlxwvlfrsgym-test.database.windows.net",
    [String] $db_name = "DATransactions",
    [String] $data_factory_name = "ghubvse-test-uks-adf-01"
   # [String] $sqlT 
)

$context = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile.DefaultContext
$sqlToken = [Microsoft.Azure.Commands.Common.Authentication.AzureSession]::Instance.AuthenticationFactory.Authenticate($context.Account, $context.Environment, $context.Tenant.Id.ToString(), $null, [Microsoft.Azure.Commands.Common.Authentication.ShowDialog]::Never, $null, "https://database.windows.net").AccessToken
Write-Host ("##vso[task.setvariable variable=SQLTOKEN;]$sqlToken")  

# idea from https://medium.com/microsoftazure/deploying-a-dacpac-to-azure-with-azure-pipelines-and-managed-identity-89703d405e00

Write-Verbose "Create SQL connectionstring"
$conn = New-Object System.Data.SqlClient.SQLConnection
#$conn.ConnectionString = "Server=$(db_server);Initial Catalog=$(db_name);Encrypt=True;TrustServerCertificate=False;Connection Timeout=30"
$conn.ConnectionString = "Server=$db_server;Initial Catalog=$db_name;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30"

$conn.AccessToken = $sqlToken
Write-Verbose "Connect to database and execute SQL script"
$conn.Open()
$query = "
IF NOT EXISTS (SELECT [name]
FROM [sys].[database_principals] WHERE [name] = N'$data_factory_name'
)
BEGIN 
 CREATE USER [$data_factory_name] FROM EXTERNAL PROVIDER WITH DEFAULT_SCHEMA=[dbo]
 EXEC sp_addrolemember 'db_owner', N'$data_factory_name';
END

ELSE
select 99
" 
Write-Host $query
$command = New-Object -TypeName System.Data.SqlClient.SqlCommand($query, $conn)
$Result = $command.ExecuteNonQuery()
$conn.Close()


