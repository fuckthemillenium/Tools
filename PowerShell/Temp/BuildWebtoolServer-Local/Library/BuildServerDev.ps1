function BuildServerDev
{
	$session = New-PSSession -ComputerName $IPAddress
	Get-ChildItem -Path "$($PSScriptRoot)" -Filter *.ps1 |Where-Object { $_.FullName -ne $PSCommandPath } | ForEach-Object {
		Invoke-Command -Session $session -File $_.FullName
	}
	
	Invoke-Command -Session $session -ScriptBlock {
		GetExecutionPolicy
		UpdateHelp
	}
<#
    GetExecutionPolicy
	UpdateHelp
    InitializeDisk
	NewItemDirectory -Dev
	UpdateEc2Launch
    InstallIIS
	ChocoInstall -Dev
	TimeZone
	#>
}