param (
    #[Parameter(Mandatory=$true)]
    [String] $AD_SecurityGroup ,
    #[Parameter(Mandatory=$true)] 
    [String] $FactoryNameUpToEnv
)

$idOfSecGroup = (Get-AzADGroup -DisplayName $AD_SecurityGroup).id
write-host $idOfSecGroup
$idOfFactory = (Get-AzADServicePrincipal -DisplayNameBeginsWith $FactoryNameUpToEnv).id
write-host $idOfFactory

$ErrorOccured = $false

try 
{ 
   $ErrorActionPreference = 'Stop'
   Add-AzADGroupMember -TargetGroupObjectId $idOfSecGroup -MemberObjectId $idOfFactory
}
catch
{
   "This user $FactoryNameUpToEnv is already a member"
   $ErrorOccured=$true
}

if(!$ErrorOccured) {
    Add-AzADGroupMember -TargetGroupObjectId $idOfSecGroup -MemberObjectId $idOfFactory -ErrorAction SilentlyContinue
    Write-Host "memeber $FactoryNameUpToEnv is now added"
}


