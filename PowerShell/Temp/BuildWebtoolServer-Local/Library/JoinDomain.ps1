function JoinDomain{
	
	$Log.Title("$($PSCommandPath)  $($MyInvocation.MyCommand.Name)")
	
	
	
	try{
		#######################################################
		# Join Domain
		#######################################################
		
		$Log.Info("Join Domain Not Configure")
	}
	catch {
		$ErrorMessage = $_.Exception.Message | Out-String
		$FailedItem = $_.Exception.ItemName | Out-String
		$Log.Error("Failed Item: $($FailedItem)")
		$Log.Error("Error Message: $($ErrorMessage)")
	}
}
