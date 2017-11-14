function ChangePassword {
	param(
		[Parameter(Mandatory = $true)][String]$NewPassword
	)
	$Log.Title("$($PSCommandPath)  $($MyInvocation.MyCommand.Name)")
	
	<#######################################################
	# Update Help
	#######################################################>
	try{
		if ($NewPassword){
			$decodedpassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::StringToBSTR($NewPassword))
			$user = [adsi]"WinNT://localhost/administrator,user"
			$user.SetPassword($decodedpassword)
			$user.SetInfo()
		}
	}
	catch {
		$ErrorMessage  = $_.Exception.Message | Out-String
		$FailedItem   = $_.Exception.ItemName | Out-String
		$Log.Error("Failed Item: $($FailedItem)")
		$Log.Error("Error Message: $($ErrorMessage)")
	}
}