# adf-sql-add-adfuser-to-sql

In order to add the ADF as a user to the SQL server you need two things. 

1. the "person" doing the dacpac deployment 
2. the SQL server itself must be added to the Directory Reader role in the AD

In the IaC you will see that the SQLAdmin security group is added to the SQL server as the admin

The way of connecting here is with Connectionstring and a token is generated from the connetion from ADO to Azure first and then passed to the dacpac deployment
