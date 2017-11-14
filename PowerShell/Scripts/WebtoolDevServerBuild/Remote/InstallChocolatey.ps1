function InstallChocolatey{
	"================================== `r`n"
	"$(Hostname): Installing Chocolatey `r`n"
	"================================== `r`n"
	#######################################################
	# Install Chocolatey
	#######################################################
	try {	
		Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
		(choco upgrade chocolatey -y)
	}
	catch {
		$ErrorMessage = $_.Exception.Message | Out-String
		$FailedItem = $_.Exception.ItemName | Out-String
		"Failed Item: $($FailedItem) `r`n"
		"Error Message: $($ErrorMessage) `r`n"
	}
}


