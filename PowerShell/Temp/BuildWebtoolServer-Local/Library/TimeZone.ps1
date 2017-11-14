function TimeZone{
	$Log.Title("$($PSCommandPath)  $($MyInvocation.MyCommand.Name)")
	#######################################################
	# Time Zone  
	#######################################################
	try {	
		$Log.Invoke("Set-TimeZone -Name `"Pacific Standard Time`"")
	}
	catch {
		$ErrorMessage = $_.Exception.Message | Out-String
		$FailedItem = $_.Exception.ItemName | Out-String
		$Log.Error("Failed Item: $($FailedItem)")
		$Log.Error("Error Message: $($ErrorMessage)")
	}

}