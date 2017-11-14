function InstallIIS{
	$Log.Title("$($PSCommandPath)  $($MyInvocation.MyCommand.Name)")
	#######################################################
	# Install Chocolatey
	#######################################################
	try {	
		$Log.Invoke("iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))")
		$Log.Invoke("choco upgrade chocolatey -y")
		
		#######################################################
		# Install IIS
		#######################################################		
		$Log.Invoke("Install-WindowsFeature -name Web-Server -IncludeManagementTools")	
	}
	catch {
		$ErrorMessage = $_.Exception.Message | Out-String
		$FailedItem = $_.Exception.ItemName | Out-String
		$Log.Error("Failed Item: $($FailedItem)")
		$Log.Error("Error Message: $($ErrorMessage)")
	}
}


