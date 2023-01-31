param (
    [String] $AD_SecurityGroup = 'SQLDataWriters',
    [String] $FactoryNameUpToEnv = 'ghubvse'
)

$idOfSecGroup = (Get-AzADGroup -DisplayName $AD_SecurityGroup).id
$idOfFactory = (Get-AzADServicePrincipal -DisplayNameBeginsWith $FactoryNameUpToEnv).id

if ($idOfFactory -eq $null) 
{Add-AzADGroupMember -TargetGroupObjectId $idOfSecGroup -MemberObjectId $idOfFactory}
else {Write-host already a member}