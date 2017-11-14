function GetSubnetId(){
process{
$Log.Subtitle("$($MyInvocation.MyCommand.Name)")
	try {
		$Log.Info("loading subnetid on $($scriptObj["Region"])")
		
		switch ($scriptObj["Region"])
		{	
			### Virginia 
			{($_ -eq "us-east-1")}{
				$scriptObj["SubnetId"] 		= "subnet-445b6802"
			}
			
			### Ireland
			{($_ -eq "eu-west-1")}{
				$scriptObj["SubnetId"] 		= "subnet-93826ce"
			}			
			
			### Sydney 
			{($_ -eq "ap-southeast-2")}{
				$scriptObj["SubnetId"] 		= "subnet-91a65cf4"
			}			
			
			Default {
				throw "Invalid Region:$($scriptObj["Region"]) `r`n"
			}
		}

	}
	catch {
		$Log.Error("$_.Exception.GetType().FullName, $_.Exception.Message")
	}
}
}