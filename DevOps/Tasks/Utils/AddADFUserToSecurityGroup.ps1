$idOfSecGroup = (Get-AzADGroup -DisplayName SQLDataWriters).id
$idOfFactory = (Get-AzADServicePrincipal -DisplayNameBeginsWith ghubvse).id

if ($idOfFactory -eq $null) 
{Add-AzADGroupMember -TargetGroupObjectId $idOfSecGroup -MemberObjectId $idOfFactory}
else {Write-host already a member}