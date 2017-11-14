#Load Script Library
. "$PSScriptRoot\Library\LoadLibrary.ps1"

Function Main {
	param(
		[switch] $Domain,
		[switch] $Password,
		[switch] $Hostname,
		[switch] $Restart
	)
    GetExecutionPolicy
	UpdateHelp
    InitializeDisk
	NewItemDirectory
	UpdateEc2Launch
    InstallIIS
	WebManagement
	WebDeploy
	ChocoInstall    
	TimeZone
			
	if ($Password){
		ChangePassword
	}
	
	if ($Hostname){
		ChangeHostname
	}
	
	if ($Domain){
		JoinDomain
	}
	
	
	if ($Restart){
		Restart-Computer -Force
	}
}

Main
