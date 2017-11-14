function WebManagement{
	$Log.Title("$($PSCommandPath)  $($MyInvocation.MyCommand.Name)")
	
	try{
		#######################################################
		# Enable Web Management Service (for Remote IIS Management)
		#######################################################
		$Log.Invoke("Dism /online /enable-feature /all /featurename:IIS-ManagementService")
		
		$Log.Invoke("Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\WebManagement\Server -Name EnableRemoteManagement -Value 1")
		$Log.Invoke("netsh advfirewall firewall add rule name=`"Allow Web Management`" dir=in action=allow service=`"WMSVC`" ")
		$Log.Invoke("Set-Service WMSvc -StartupType Automatic")
		$Log.Invoke("Stop-Service WMSvc")
		$Log.Invoke("Start-Service WMSvc")
		
		
		$Log.Invoke("Get-WindowsFeature | Where Installed")
		$Log.Invoke("netstat -aon | findstr :8172")
	}
	catch {
		$ErrorMessage = $_.Exception.Message | Out-String
		$FailedItem = $_.Exception.ItemName | Out-String
		$Log.Error("Failed Item: $($FailedItem)")
		$Log.Error("Error Message: $($ErrorMessage)")
	}
}
