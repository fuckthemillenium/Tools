function GetIpAddress(){
	try{
		### Create Elastic Ip if Production or Implementation	
		if ( ($($scriptObj["Environment"]) -eq "Production") -or ($($scriptObj["Environment"]) -eq "Implementation")) {
			$Log.Info("creating public ip")
			$ec2Address 	= New-EC2Address -Domain Vpc
			$publicIP 		= $ec2Address.PublicIP
			$allocationid 	= $ec2Address.AllocationId
			Register-EC2Address -InstanceId $scriptObj["InstanceID"] -AllocationId $allocationid
			$scriptObj["PublicIpAddress"]  = (Get-Ec2Instance -InstanceId $scriptObj["InstanceID"] -Region $scriptObj["Region"]).Instances.PublicIpAddress
		}
	}
	catch {
		$Log.Error("$_.Exception.GetType().FullName, $_.Exception.Message")
	}
}