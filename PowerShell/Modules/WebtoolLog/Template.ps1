<###########################################################
### Logging Example
###########################################################>
### Load Class Module for Logging
using module "D:\PowerShell\Modules\WebtoolLog\WebtoolLog.psm1"
### Initiate Loging from Source Parent Script
$Log = [WebtoolLog]::new("$(Split-Path $MyInvocation.ScriptName -Leaf)")


function Template{
	$Log.Title("$($PSCommandPath)  $($MyInvocation.MyCommand.Name)")
	#######################################################
	# Log Template
	#######################################################

	try {
		$Log.Info("info")
		$Log.Error("error")
		$Log.Invoke("dir")
	}
	catch {
		$ErrorMessage = $_.Exception.Message | Out-String
		$FailedItem = $_.Exception.ItemName | Out-String
		$Log.Error("Failed Item: $($FailedItem)")
		$Log.Error("Error Message: $($ErrorMessage)")
	}
}