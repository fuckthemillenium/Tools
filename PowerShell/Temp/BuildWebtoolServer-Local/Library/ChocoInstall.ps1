function ChocoInstall {
	param(
		[switch] $Dev,
		[switch] $App
	)
	
	$Log.Title("$($PSCommandPath)  $($MyInvocation.MyCommand.Name)")
	#######################################################
	# Install Chocolatey
	#######################################################
	try {	
		$Log.Invoke("iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))")
		$Log.Invoke("choco upgrade chocolatey -y")
		
		#######################################################
		# Install Notepad++
		#######################################################		
		$Log.Invoke("choco install notepadplusplus -y")
		$Log.Invoke("choco upgrade notepadplusplus -y")		
				
		#######################################################
		# Install Git
		#######################################################
		$Log.Invoke("choco install git.install -y")
		$Log.Invoke("choco upgrade git.install -y")		
		
		if ($Dev){
			#######################################################
			# Install Visual Studio Community
			#######################################################
			$Log.Invoke("choco install visualstudio2017community -y")
			$Log.Invoke("choco upgrade visualstudio2017community -y")
		} else {
			
		
		}
		
	}
	catch {
		$ErrorMessage = $_.Exception.Message | Out-String
		$FailedItem = $_.Exception.ItemName | Out-String
		$Log.Error("Failed Item: $($FailedItem)")
		$Log.Error("Error Message: $($ErrorMessage)")
	}
	
}