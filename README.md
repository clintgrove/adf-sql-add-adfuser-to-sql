# adf-sql-add-adfuser-to-sql


Pre requisites for any new set up
1. Add the ADO (azure devops) Service Connection as a Directory Reader in your Active Directory. And of course when you create this Service Connection it will have Contributor rights, either on the subscription or the resource group, depending on how you set it up in ADO.
2. Create Security Groups (SG) in each of your environments to house members for SQL read and write. We will be adding the ADF to this SG. 
3. Create Security Groups (SG) in each of your environments to house members for SQL Admins. We will be adding the ADO to this SG. You can chose to have one SQLAdmin for all environments though. Thats up to you. 

These two steps above can be done before project starts. They are purely Active Directory tasks. 

In order to get the ADF included as a user in the SQL Server Database there are a couple of things to tick off during your CI/CD process. 

- Add the SQLadmin SG to your newly created SQL server. See the AzureSQL.json file under the Infrastrucutre to see this in action 





OLD---

In order to add the ADF as a user to the SQL server you need two things. 

1. the "person" doing the dacpac deployment 
2. the SQL server itself must be added to the Directory Reader role in the AD

In the IaC you will see that the SQLAdmin security group is added to the SQL server as the admin

The way of connecting here is with Connectionstring and a token is generated from the connetion from ADO to Azure first and then passed to the dacpac deployment
