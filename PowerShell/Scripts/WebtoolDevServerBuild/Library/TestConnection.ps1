function TestConnection{
	param(
		[Parameter(Mandatory=$true)][string]   $InstanceID,
		[Parameter(Mandatory=$true)][string]   $Region,
		[Parameter(Mandatory=$true)][string[]] $IpAddress,
        [Parameter(Mandatory=$true)][PSCredential] $Credential
	)
	
	$Log.Title("$($PSCommandPath)  $($MyInvocation.MyCommand.Name)")
	$Log.Info("TestConnection -InstancdID $InstanceID -Region $Region -IpAddress $IpAddress -Credential `$Credential")
	

	$timer = 0
    $Obj["TestConnection"] = "false"
	do {
		$timer++
        $connection = New-Object TestPowerShellConnection
		$connection.Test($IpAddress, $Credential)
		$connection.Status | Format-Table
		
		if ($connection.Status.PSSession) {
            $Log.Info("Connection: $($connection.Status.PSSession).  Established remote connection. `r`n")
            $Obj["TestConnection"] = "true"
			break
		}
		
		$Log.Info("Connection: $($connection.Status.PSSession).  Waiting for established remote connection.  Time elasped: $timer (minutes) `r`n")
        $Log.Info("Please verify that remote client already ran this command `r`n")
        $Log.Info("Enable-PSRemoting -SkipNetworkProfileCheck -Force  `r`n")
        $Log.Info("Set-NetFirewallRule -Name `"WINRM-HTTP-In-TCP-PUBLIC`" -RemoteAddress Any  `r`n")

		#"Waiting for established remote connection.  Time elasped: $timer (minutes) `r`n"
		Start-Sleep -s "30"
	} until (($($connection.Status.PSSession)) -Or ( $timer -gt "20" ))
	
}
