function WebDeploy{
	$Log.Title("$($PSCommandPath)  $($MyInvocation.MyCommand.Name)")
	
	try{
		#######################################################
		# Install IIS Web Deploy
		#######################################################
		$Log.Invoke("choco install webdeploy -y")
		$Log.Invoke("choco upgrade webdeploy -y")
		$Log.Invoke("netsh advfirewall firewall add rule name=`"Allow Web Deployment`" dir=in action=allow service=`"MsDepSvc`" ")
		$Log.Invoke("Set-Service MsDepSvc -StartupType Automatic")
		$Log.Invoke("Stop-Service MsDepSvc")
		$Log.Invoke("Start-Service MsDepSvc")
	}
	catch {
		$ErrorMessage = $_.Exception.Message | Out-String
		$FailedItem = $_.Exception.ItemName | Out-String
		$Log.Error("Failed Item: $($FailedItem)")
		$Log.Error("Error Message: $($ErrorMessage)")	
	}
}