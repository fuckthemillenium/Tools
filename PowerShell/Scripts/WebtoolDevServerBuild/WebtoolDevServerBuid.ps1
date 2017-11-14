param(
	[Parameter(Mandatory=$true)][string] $Environment,
	[Parameter(Mandatory=$true)][string] $NewHostname,
	[Parameter(Mandatory=$true)][string] $NewPassword,
    
    ### Skip Server Build
    [string] $InstanceID,
	[string] $Region
)


<##################################################
	Load Script Library
##################################################>
. "$PSScriptRoot\Library\LoadLibrary.ps1"


$Log.Title("$($PSCommandPath)  $($MyInvocation.MyCommand.Name)")


<##################################################
	Initializing Global Object
##################################################>
$Obj = @{}
$Obj["Environment"] = "$($Environment)"



<##################################################
	Build Server according to Environment input
##################################################>
switch($($Environment)){
	{($_ -eq "Dev") -or ($_ -eq "Prod")}{
        ####################
        ### Set $Obj variables depend on selected Environment
        ####################
        SetEnvironment

        if ( ($InstanceID) -and ($Region) )
        {
            $Obj["InstanceID"]  = "$($InstanceID)"
            $Obj["Region"]    = "$($Region)"
        } else { 
		    ####################
            ### Create AWS Webtool base instance
            ####################
		    CreateWebtoolInstance
        }

        ####################
		### Get Public and Private Ip
        ####################
		$Instance = (Get-EC2Instance -InstanceId $Obj["InstanceId"] -Region $Obj["Region"] ).Instances
		$Obj["PrivateIpAddress"] = $Instance.PrivateIpAddress
		$Obj["PublicIpAddress"] = $Instance.PublicIpAddress
		
        ####################
		### Select 1 Network
        ####################
        $IpAddress = $Obj["PrivateIpAddress"]
        #$IpAddress = $Obj["PublicIpAddress"]
		
        ####################
        ### Get Credential
        ####################
		GetCredential  -InstanceID $Obj["InstanceID"] -Region $Obj["Region"]


        ####################
        ### Test Connection, If Fail, please ensure remote system has this set
        <#
        Enable-PSRemoting -SkipNetworkProfileCheck -Force
        Set-NetFirewallRule -Name "WINRM-HTTP-In-TCP-PUBLIC" -RemoteAddress Any
        #>
        ####################

		TestConnection -InstanceID $Obj["InstanceID"] -Region $Obj["Region"] -IpAddress $IpAddress -Credential $($Obj["Credential"])
        if( -Not ($($Obj["TestConnection"])) ) {
            $Log.Error("Cannot establish Remote Connection")
            $Log.Warning("Enable PSRemote or Fix the connection, then run the command below to continue `r`n")
            $Log.Warning(".\WebtoolDevApplicationDeployOnly.ps1 -InstanceID `"$($Obj["InstanceID"])`" -Region `"$($Obj["Region"])`" -NewHostname `"$NewHostname`" -Environment `"$Environment`" -NewPassword `"$NewPassword`" ")
            exit 
         }


        <####################
			Set-TimeZone -Name "Pacific Standard Time"
			SetExecutionPolicy
			UpdateHelp
			InitializeDisk
            NewItemDirectory -Dev
            UpdateEc2Launch
			InstallChocolatey
        ####################>
        $Log.Title("Application Installation Phrase 1")
		$session = New-PSSession -ComputerName $IpAddress -Credential $Obj["Credential"]
		Get-ChildItem -Path "$($PSScriptRoot)\Remote" -Filter *.ps1 | Where-Object { $_.FullName -ne $PSCommandPath } | ForEach-Object {
			$Log.Info("Loading script to PSSession: $($_.FullName)")
			Invoke-Command -Session $session -File $_.FullName
		}
	    $Log.Remote((Invoke-Command -Session $session -ScriptBlock {
            "$(Hostname)`r`n"
			Set-TimeZone -Name "Pacific Standard Time"
			SetExecutionPolicy
			UpdateHelp
			InitializeDisk
            NewItemDirectory -Dev
            UpdateEc2Launch
			InstallChocolatey
            Restart-Computer -Force
		}))
		Remove-PSSession $session

		TestConnection -InstanceID $Obj["InstanceID"] -Region $Obj["Region"] -IpAddress $IpAddress -Credential $($Obj["Credential"])
        if( -Not ($($Obj["TestConnection"])) ) {
            $Log.Error("Cannot establish Remote Connection")
            exit 
         }
 
		
        <####################
            Install IIS and Web Deploy Features
            Change Hostname
            reboot
        ####################>
        $Log.Title("Application Installation Phrase 2")
		$session = New-PSSession -ComputerName $IpAddress -Credential $Obj["Credential"]
		Get-ChildItem -Path "$($PSScriptRoot)\Remote" -Filter *.ps1 | Where-Object { $_.FullName -ne $PSCommandPath } | ForEach-Object {
			$Log.Info("Loading script to PSSession: $($_.FullName)")
			Invoke-Command -Session $session -File $_.FullName
		}
	    $Log.Remote((Invoke-Command -Session $session -ScriptBlock {
			param($NewHostname, $NewPassword)
 			InstallIIS
			ChocoInstall
            ChangePassword
			"Change Hostname: $($NewHostname) `r`n"
			"Reboot Computer `r`n"
			Rename-Computer -NewName "$NewHostname"  -Restart -Force
		} -ArgumentList $NewHostname,$NewPassword ))		
		Remove-PSSession $session
	}
	

	Default
	{
		$Log.Error("Invalid Environment: $Environment")
        $Log.Info("Please use Environment: Dev or Prod")
	}
}



$Log.Title("Result Summary")
$Log.Info("$($Obj | Format-Table -Auto | Out-string)")
$Log.Title("Script Completed")