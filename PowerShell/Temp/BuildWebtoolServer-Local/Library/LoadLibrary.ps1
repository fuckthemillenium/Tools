<###########################################################
### Loging
###########################################################>
### Load Class Module for Logging
using module "D:\Scripts\Modules\WebtoolLog\WebtoolLog.psm1"
### Initiate Loging from Source Parent Script
$Log = [WebtoolLog]::new("$(Split-Path $MyInvocation.ScriptName -Leaf)")


<###########################################################
### Load All Scripts in Library
###########################################################>
### Load Every script in library excluding this script (prevent multiple self calling).
$Log.Title("Load Library Scripts")
Get-ChildItem -Path "$($PSScriptRoot)" -Filter *.ps1 |Where-Object { $_.FullName -ne $PSCommandPath } | ForEach-Object {
    $Log.Info("$($_.FullName)")
	. $_.FullName
}


