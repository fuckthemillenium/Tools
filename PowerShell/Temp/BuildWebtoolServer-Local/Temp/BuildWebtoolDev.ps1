#Load Script Library
. "$PSScriptRoot\Library\LoadLibrary.ps1"

Function Main {
	param(
		[switch] $Dev,
		[switch] $Password,
		[switch] $Hostname,
		[switch] $Restart
	)
    GetExecutionPolicy
	UpdateHelp
    InitializeDisk
	NewItemDirectory -Dev
	UpdateEc2Launch
    InstallIIS
	ChocoInstall -Dev
	
	TimeZone
		
	if ($Password){
		ChangePassword
	}
	
	if ($Hostname){
		ChangeHostname
	}
	
	if ($Restart){
		Restart-Computer -Force
	}
}

Main
