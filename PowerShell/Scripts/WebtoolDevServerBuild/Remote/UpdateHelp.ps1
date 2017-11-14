function UpdateHelp {
	"================================== `r`n"
	"$(Hostname): Update-Help `r`n"
	"================================== `r`n"
	
	<#######################################################
	# Update Help
	#######################################################>
	try{
		"$(Update-Help  -Force -Ea 0)`r`n"
	}
	catch {
		$ErrorMessage = $_.Exception.Message | Out-String
		$FailedItem = $_.Exception.ItemName | Out-String
		"Failed Item: $($FailedItem)"
		"Error Message: $($ErrorMessage)"
	}
}