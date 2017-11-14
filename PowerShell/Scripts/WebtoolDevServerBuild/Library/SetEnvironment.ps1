function SetEnvironment(){
	$Log.Title("$($PSCommandPath)  $($MyInvocation.MyCommand.Name)")
	switch($Obj["Environment"]){
		"Dev" {
			$Obj["Region"]    	= "us-west-1"
			$Obj["SubnetId"] 		= "subnet-d61b3ab3"
			$Obj["SecurityGroupId"] = "sg-3be6125f"
		}
		"Prod" {
			$Obj["Region"]    	= "us-east-1"
			$Obj["SubnetId"] 		= "subnet-bc5467fa"
			$Obj["SecurityGroupId"] = "sg-d60a52ae"
		}
		"App" {
			$Obj["Region"]    	= "us-east-1"
			$Obj["SubnetId"] 		= "subnet-bc5467fa"
			$Obj["SecurityGroupId"] = "sg-d60a52ae"
		}
		Default {
			$Obj["Region"]    	= ""
			$Obj["SubnetId"] 		= ""
			$Obj["SecurityGroupId"] = ""
		}	
	}
	
	$Log.Output("$($Obj | Format-Table -Auto | Out-string)")
}	


