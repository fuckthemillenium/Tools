
<##################################################
	Load Script Library
##################################################>
. "$PSScriptRoot\Library\LoadLibrary.ps1"
. "$PSScriptRoot\Remote\InstallIIS.ps1"
. "$PSScriptRoot\Remote\ChocoInstall.ps1"

$Log.Title("$($PSCommandPath)  $($MyInvocation.MyCommand.Name)")


<##################################################
	Initializing Global Object
##################################################>
$Obj = @{}
$Obj["Environment"] = "$($Environment)"



<##################################################
	Build Server according to Environment input
##################################################>
<#
			Set-TimeZone -Name "Pacific Standard Time"
			SetExecutionPolicy
			UpdateHelp
			InitializeDisk
            NewItemDirectory -Dev
            UpdateEc2Launch
			InstallChocolatey
            Restart-Computer -Force
 #>
 			InstallIIS
			ChocoInstall

$Log.Title("Result Summary")
$Log.Info("$($Obj | Format-Table -Auto | Out-string)")
$Log.Title("Script Completed")