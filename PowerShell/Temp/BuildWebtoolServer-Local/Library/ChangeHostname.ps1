function ChangeHostname {
	param(
		[Parameter(Mandatory = $true)][String]$NewHostname
	)
	$Log.Title("$($PSCommandPath)  $($MyInvocation.MyCommand.Name)")
	
	<#######################################################
	# Change Password
	#######################################################>
	try{
		if($NewHostname){
			Rename-Computer -NewName "$NewHostname" 
		}
	}
	catch {
		$ErrorMessage  = $_.Exception.Message | Out-String
		$FailedItem   = $_.Exception.ItemName | Out-String
		$Log.Error("Failed Item: $($FailedItem)")
		$Log.Error("Error Message: $($ErrorMessage)")
	}
}
