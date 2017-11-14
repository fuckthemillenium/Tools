function InstallIIS{
	"================================== `r`n"
	"$(Hostname): Installing IIS `r`n"
	"================================== `r`n"
	try {
		#######################################################
		# Install IIS
		#######################################################	
		(Install-WindowsFeature -name Web-Server -IncludeManagementTools)
		(Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpRedirect)
		" `r`n"
	}
	catch {
		$ErrorMessage = $_.Exception.Message | Out-String
		$FailedItem = $_.Exception.ItemName | Out-String
		"Failed Item: $($FailedItem) `r`n"
		"Error Message: $($ErrorMessage) `r`n"
	}
	
	"================================== `r`n"
	"$(Hostname): Enable Web Management Service (for Remote IIS Management) `r`n"
	"================================== `r`n"	
	try{
		#######################################################
		# Enable Web Management Service (for Remote IIS Management)
		#######################################################
		Dism /online /enable-feature /all /featurename:IIS-ManagementService
		netstat -aon | findstr :8172
		Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\WebManagement\Server -Name EnableRemoteManagement -Value 1
		netsh advfirewall firewall add rule name="Allow Web Management" dir=in action=allow service="WMSVC"
		Set-Service WMSvc -StartupType Automatic
		Stop-Service WMSvc
		Start-Service WMSvc
		}
	catch {
		$ErrorMessage = $_.Exception.Message | Out-String
		$FailedItem = $_.Exception.ItemName | Out-String
		"Failed Item: $($FailedItem) `r`n"
		"Error Message: $($ErrorMessage) `r`n"
	}
	
	"================================== `r`n"
	"$(Hostname): Install IIS Web Deploy `r`n"
	"================================== `r`n"		
	try {
		#######################################################
		# Install IIS Web Deploy
		#######################################################
		"Please Download and Check MSI vserion 3.5 Package. Insure IIS Deployment Handler is selected, if this does not work `r`n"
		choco install webdeploy -y
		#choco upgrade webdeploy -y
		netsh advfirewall firewall add rule name="Allow Web Deployment" dir=in action=allow service="MsDepSvc"
		Set-Service MsDepSvc -StartupType Automatic
		Stop-Service MsDepSvc
		Start-Service MsDepSvc
	}
	catch {
		$ErrorMessage = $_.Exception.Message | Out-String
		$FailedItem = $_.Exception.ItemName | Out-String
		"Failed Item: $($FailedItem) `r`n"
		"Error Message: $($ErrorMessage) `r`n"
	}
	
	"================================== `r`n"
	"$(Hostname): ASP.net Core `r`n"
	"================================== `r`n"		
	try {
		#######################################################
		# ASP.net Core Server Hosting Bundle
		#   required for ASP Core where IIS error on web.config
		#######################################################	
		choco install dotnetcore -y
		choco install dotnetcore-sdk -y
		#choco upgrade dotnetcore -y
		}
	catch {
		$ErrorMessage = $_.Exception.Message | Out-String
		$FailedItem = $_.Exception.ItemName | Out-String
		"Failed Item: $($FailedItem) `r`n"
		"Error Message: $($ErrorMessage) `r`n"
	}
	
	
	"================================== `r`n"
	"$(Hostname): ASP.net Core Server Hosting Bundle `r`n"
	"================================== `r`n"		
	try {
		#######################################################
		# ASP.net Core Server Hosting Bundle
		#   required for ASP Core where IIS error on web.config
		#######################################################	
		choco install dotnetcore-windowshosting -y
		#choco upgrade dotnetcore-windowshosting -y
		}
	catch {
		$ErrorMessage = $_.Exception.Message | Out-String
		$FailedItem = $_.Exception.ItemName | Out-String
		"Failed Item: $($FailedItem) `r`n"
		"Error Message: $($ErrorMessage) `r`n"
	}	
}

