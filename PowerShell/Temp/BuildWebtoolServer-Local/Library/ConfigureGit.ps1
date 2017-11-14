function ConfigureGit{
	$Log.Title("$($PSCommandPath)  $($MyInvocation.MyCommand.Name)")
	#######################################################
	# Configure Git
	#######################################################
	try {
		iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
		choco upgrade chocolatey -y
		
		git config --global http.sslVerify false
		git config --global user.name "KT"
		git config --global user.email "khanh.v.tran@oracle.com"
		#######################################################
		# Git Clone
		#######################################################
		cd d:\
		git clone https://34.200.121.245/webtoolv3/Scripts.git
		git clone https://ops-gitlab.ns-pos.com/webtoolv3/Scripts.git
	}
	catch {
		$ErrorMessage = $_.Exception.Message | Out-String
		$FailedItem = $_.Exception.ItemName | Out-String
		$Log.Error("Failed Item: $($FailedItem)")
		$Log.Error("Error Message: $($ErrorMessage)")
	}
}