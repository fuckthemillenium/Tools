function GetSecurityGroups(){
process{
	$Log.Subtitle("$($MyInvocation.MyCommand.Name)")
		try {
			$Log.Info("loading security groups on [$($scriptObj["Region"]) | $($scriptObj["Environment"])]")
			$securityGroupIds = New-Object System.Collections.ArrayList
			
			switch ($scriptObj["Region"])
			{	
				### Virginia [ Production | Implementation ]
				{($_ -eq "us-east-1") -And (($($scriptObj["Environment"]) -eq "Production") -Or ($($scriptObj["Environment"]) -eq "Implementation"))}{
					$securityGroupIds.Add("sg-bf09c8c3") | Out-Null	# Production
					$securityGroupIds.Add("sg-f2d00496") | Out-Null	# NetSuiteProdIPs
				}
				
				### Ireland [ Production | Implementation ]
				{($_ -eq "eu-west-1") -And (($($scriptObj["Environment"]) -eq "Production") -Or ($($scriptObj["Environment"]) -eq "Implementation"))}{
					$securityGroupIds.Add("sg-d21c55b4") | Out-Null	# Production
					$securityGroupIds.Add("sg-e9bd408d") | Out-Null	# NetSuiteProdIPs
				}			
				
				### Sydney [ Production | Implementation ]
				{($_ -eq "ap-southeast-2") -And (($($scriptObj["Environment"]) -eq "Production") -Or ($($scriptObj["Environment"]) -eq "Implementation"))}{
					$securityGroupIds.Add("sg-67589700") | Out-Null	# Production
					$securityGroupIds.Add("sg-50f67835") | Out-Null	# NetSuiteProdIPs
				}			
				
				Default {
					throw "Invalid combination of Region:$($scriptObj["Region"]) and Environment:$($scriptObj["Environment"])`r`n"
				}
			}
			
			$scriptObj["SecurityGroupId"] = $securityGroupIds
		}
		catch {
			$Log.Error("$_.Exception.GetType().FullName, $_.Exception.Message")
		}
}
}