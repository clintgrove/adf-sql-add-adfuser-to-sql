[CmdletBinding(DefaultParameterSetName = 'None')]
param
(
  [String] [Parameter(Mandatory = $true)] $ServerName,
  [String] [Parameter(Mandatory = $true)] $ResourceGroupName,
  [String] $FirewallRuleName = "AzureWebAppFirewall"
)
Remove-AzSqlServerFirewallRule -ServerName $ServerName -FirewallRuleName $FirewallRuleName -ResourceGroupName $ResourceGroupName