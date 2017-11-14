function CreateInstance(){
<#
	Create Instance
	Get Instance ID
	Get Instance Public IP (if Environment is Production or Implementation)
	Get Instance Private IP
#>
process{
	$Log.Subtitle("$($MyInvocation.MyCommand.Name)")
	try {
		$reservation = New-EC2Instance `
			-ImageId "$($scriptObj["AmiID"])" `
			-SubnetId "$($scriptObj["SubnetId"])" `
			-SecurityGroupId $($scriptObj["SecurityGroupId"]) `
			-BlockDeviceMapping $($scriptObj["BlockDeviceMapping"]) `
			-AvailabilityZone "$($scriptObj["AvailabilityZone"])" `
			-InstanceType "$($scriptObj["InstanceType"])" `
			-DisableApiTermination $true `
			-MinCount 1 `
			-MaxCount 1 `
			-KeyName 'OPSTools' `
			
		
		$scriptObj["InstanceID"] = $reservation.Instances.InstanceId
		
		
		$scriptObj["InstanceState"] = "pending"
		$timeElasped = 1
		while ( $scriptObj["InstanceState"] -ne "running" ){
			 
			$Log.Info("$($scriptObj["InstanceID"]) state: $($scriptObj["InstanceState"]) ... please wait 60 seconds for update ... time elasped: $timeElasped minute(s)")
			$timeElasped = $timeElasped + 1
			Start-Sleep -seconds 60
			$scriptObj["InstanceState"] = (Get-Ec2Instance -InstanceId $scriptObj["InstanceID"] -Region $scriptObj["Region"]).Instances.State.Name
			
			if( ($scriptObj["InstanceState"] -ne "running") -And ($scriptObj["InstanceState"] -ne "pending")){
				throw "$($scriptObj["InstanceID"]) state: $($scriptObj["InstanceState"])"
				break
			}
		}
		$Log.Info("created instance $($scriptObj["InstanceID"]) state: $($scriptObj["InstanceState"])")
		$scriptObj["PrivateIpAddress"] = (Get-Ec2Instance -InstanceId $scriptObj["InstanceID"] -Region $scriptObj["Region"]).Instances.PrivateIpAddress

		
	}
	catch {
		$Log.Error("$_.Exception.GetType().FullName, $_.Exception.Message")
	}
}
}