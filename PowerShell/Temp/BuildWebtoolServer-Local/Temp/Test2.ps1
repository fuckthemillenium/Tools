. "$PSScriptRoot\Library\LoadLibrary.ps1"
Start-Job -ScriptBlock {
	try {	
		git config --global http.sslVerify false
		git config --global user.name "KT"
		git config --global user.email "khanh.v.tran@oracle.com"
		#######################################################
		# Git Clone
		#######################################################
		cd d:\
		git clone https://34.200.121.245/webtoolv3/Scripts.gi
	}
	catch {
		$ErrorMessage = $_.Exception.Message | Out-String
		$FailedItem = $_.Exception.ItemName | Out-String
		$FailedItem | Out-File "D:\Logs\git.log" -Append
		$ErrorMessage | Out-File "D:\Logs\git.log" -Append
	}
}
