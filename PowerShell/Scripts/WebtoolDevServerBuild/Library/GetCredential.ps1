function GetCredential(){
<# Get System Credential using AWS pem and default User: Administrator" #>
	param(
		[Parameter(Mandatory=$true)][string]   $InstanceID,
		[Parameter(Mandatory=$true)][string]   $Region
	)
	
	$Log.Title("$($PSCommandPath)  $($MyInvocation.MyCommand.Name)")
	$Log.Info("GetCredential: $InstanceID $Region")
	
	$credential = New-Object GetEc2Password($InstanceID, $Region)
	$username = "Administrator"	
	$password = $credential.Password
	$secPassword = ConvertTo-SecureString $password -AsPlainText -Force
	$Obj["Credential"] = New-Object System.Management.Automation.PSCredential ($username, $secPassword)
}