$scriptObj = @{}
$scriptObj["Awsname"]     = "Test Customer"
$scriptObj["Region"]      = "us-east-1"
$scriptObj["InstanceId"]  = "i-08fea605ea6502ede"



$volumes = (Get-Ec2Instance -InstanceId "$($scriptObj["InstanceId"])").Instances
$volumes


<#
function TagVolume(){
	$Log.Subtitle("$($MyInvocation.MyCommand.Name)")
	try {
		$tags = @(	@{ Key="Name";  	    Value="$($scriptObj['AwsName'])" },`
					@{ Key="InstanceId";  	Value="$($scriptObj['InstanceId'])" },`
					@{ Key="Volume"; 	    Value="$volume" }`
				)
		
		New-EC2Tag -ResourceId $resourceid -Tags $tags -Region $scriptObj["Region"]
		$Log.Info("success created tags for new volume: $($resourceid)")
	}
	catch {
		 $_.Exception.Message
		$Log.Error("$_.Exception.GetType().FullName, $_.Exception.Message")
	}
}
#>