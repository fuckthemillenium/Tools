<##############################################################
	Loading required custom modules 
<##############################################################>

using module "D:\PowerShell\Modules\WebtoolLog\WebtoolLog.psm1"
using module "D:\PowerShell\Modules\TestPowerShellConnection\TestPowerShellConnection.psm1"
using module "D:\PowerShell\Modules\GetEc2Password\GetEc2Password.psm1"

Import-Module AWSPowerShell
<##############################################################
	Initiate $Log module using script name
		calling Powershell WebtoolLog construct
###############################################################>		
$Log = [WebtoolLog]::new("$(Split-Path $MyInvocation.ScriptName -Leaf)")


<##############################################################
	Load Every script in library 
		Filter only *.ps1 files
		Where-Object exclude this script (prevent multiple self calling)
##############################################################>
$Log.Title("Load Library's Scripts")
Get-ChildItem -Path "$($PSScriptRoot)" -Filter *.ps1 |Where-Object { $_.FullName -ne $PSCommandPath } | ForEach-Object {
    $Log.Info("$($_.FullName)")
	. $_.FullName
}