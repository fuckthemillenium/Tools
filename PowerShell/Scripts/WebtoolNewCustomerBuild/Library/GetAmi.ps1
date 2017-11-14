function GetAmi(){
process{
	$Log.Subtitle("$($MyInvocation.MyCommand.Name)")
	try {
		$Log.Info("loading ami on $($scriptObj["Region"])")
		
		switch ($scriptObj["Region"])
		{	
			### Virginia 
			{($_ -eq "us-east-1")}{
				$scriptObj["AvailabilityZone"]	= "us-east-1d"
				$scriptObj["AmiID"]				= "ami-94672682"
				$scriptObj["AmiPassword"]		= 'a.g8&LP;U('
			}
			
			### Ireland
			{($_ -eq "eu-west-1")}{
				$scriptObj["AvailabilityZone"]	= "eu-west-1b"
				$scriptObj["AmiID"] 			= "ami-896a7eef"
				$scriptObj["AmiPassword"]		= '-.-!Fm&?6A'
			}			
			
			### Sydney 
			{($_ -eq "ap-southeast-2")}{
				$scriptObj["AvailabilityZone"]	= "ap-southeast-2b"
				$scriptObj["AmiID"] 			= "ami-787e6a1b"
				$scriptObj["AmiPassword"]		= 'iwwCFA2Huy='
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