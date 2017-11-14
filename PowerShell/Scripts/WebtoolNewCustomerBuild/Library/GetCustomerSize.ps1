function GetCustomerSize(){
	$Log.Subtitle("$($MyInvocation.MyCommand.Name)")
	try {
		$Log.Info("loading customer size: $($scriptObj["CustomerSize"]) ")
		
		$blockDeviceMapping = @()
	
		switch ($scriptObj["CustomerSize"])
		{	
			"Small" {
				$scriptObj["InstanceType"] = "m3.large"	
				$disks = @(
					[PSCustomObject] @{ Drive = "C"; DeviceName = '/dev/sda1';	VolumeSize = "100";	VolumeType = "standard"	};
					[PSCustomObject] @{ Drive = "D"; DeviceName = 'xvdb'; 		VolumeSize = "100";	VolumeType = "gp2" 		};
					[PSCustomObject] @{ Drive = "E"; DeviceName = 'xvde'; 		VolumeSize = "100";	VolumeType = "gp2"		};
					[PSCustomObject] @{ Drive = "P"; DeviceName = 'xvdp';		VolumeSize = "200";	VolumeType = "standard" };
					[PSCustomObject] @{ Drive = "T"; DeviceName = 'xvdt';		VolumeSize = "40"; 	VolumeType = "gp2"		};
					[PSCustomObject] @{ Drive = "Y"; DeviceName = 'xvdy';		VolumeSize = "100";	VolumeType = "standard" };
					[PSCustomObject] @{ Drive = "L"; DeviceName = 'xvdl';		VolumeSize = "20";	VolumeType = "standard" }
					)
			}
				
			"Medium" {
				$scriptObj["InstanceType"] = "r3.large"
				$disks = @(
					[PSCustomObject] @{ Drive = "C"; DeviceName = '/dev/sda1';	VolumeSize = "100";	VolumeType = "standard"	};
					[PSCustomObject] @{ Drive = "D"; DeviceName = 'xvdd'; 		VolumeSize = "200";	VolumeType = "gp2" 		};
					[PSCustomObject] @{ Drive = "E"; DeviceName = 'xvde'; 		VolumeSize = "100";	VolumeType = "gp2"		};
					[PSCustomObject] @{ Drive = "P"; DeviceName = 'xvdp';		VolumeSize = "300";	VolumeType = "standard" };
					[PSCustomObject] @{ Drive = "T"; DeviceName = 'xvdt';		VolumeSize = "40"; 	VolumeType = "gp2"		};
					[PSCustomObject] @{ Drive = "Y"; DeviceName = 'xvdy';		VolumeSize = "200";	VolumeType = "standard" };
					[PSCustomObject] @{ Drive = "L"; DeviceName = 'xvdl';		VolumeSize = "20";	VolumeType = "standard" }
					)
			}
			
			"Large"	{
				$scriptObj["InstanceType"] = "r3.xlarge"
				$disks = @(
					[PSCustomObject] @{ Drive = "C"; DeviceName = '/dev/sda1';	VolumeSize = "100";	VolumeType = "standard"	};
					[PSCustomObject] @{ Drive = "D"; DeviceName = 'xvdd'; 		VolumeSize = "400";	VolumeType = "gp2" 		};
					[PSCustomObject] @{ Drive = "E"; DeviceName = 'xvde'; 		VolumeSize = "200";	VolumeType = "gp2"		};
					[PSCustomObject] @{ Drive = "P"; DeviceName = 'xvdp';		VolumeSize = "400";	VolumeType = "standard" };
					[PSCustomObject] @{ Drive = "T"; DeviceName = 'xvdt';		VolumeSize = "40"; 	VolumeType = "gp2"		};
					[PSCustomObject] @{ Drive = "Y"; DeviceName = 'xvdy';		VolumeSize = "400";	VolumeType = "standard" };
					[PSCustomObject] @{ Drive = "L"; DeviceName = 'xvdl';		VolumeSize = "20";	VolumeType = "standard" }
					)
			}		
			
			"xLarge" {
				$scriptObj["InstanceType"] = "r3.2xlarge"
				$disks = @(
					[PSCustomObject] @{ Drive = "C"; DeviceName = '/dev/sda1';	VolumeSize = "100";  VolumeType = "standard" };
					[PSCustomObject] @{ Drive = "D"; DeviceName = 'xvdd'; 		VolumeSize = "800";	 VolumeType = "gp2" 	 };
					[PSCustomObject] @{ Drive = "E"; DeviceName = 'xvde'; 		VolumeSize = "500";	 VolumeType = "gp2"		 };
					[PSCustomObject] @{ Drive = "P"; DeviceName = 'xvdp';		VolumeSize = "1000"; VolumeType = "standard" };
					[PSCustomObject] @{ Drive = "T"; DeviceName = 'xvdt';		VolumeSize = "40"; 	 VolumeType = "gp2"		 };
					[PSCustomObject] @{ Drive = "Y"; DeviceName = 'xvdy';		VolumeSize = "600";	 VolumeType = "standard" };
					[PSCustomObject] @{ Drive = "L"; DeviceName = 'xvdl';		VolumeSize = "20";	 VolumeType = "standard" }
					)
			}			
			
			Default {
				throw "Invalid Customer Size:$($scriptObj["CustomerSize"]) `r`n"
			}
		}
		$Log.Output("$($disks | Out-String)")
		
		
		foreach($disk in $disks){
			$volume = New-Object Amazon.EC2.Model.EbsBlockDevice
			$volume.DeleteOnTermination = $true
			$volume.VolumeSize = $disk.VolumeSize
			$volume.VolumeType = $disk.VolumeType
		
			$deviceMapping = New-Object Amazon.EC2.Model.BlockDeviceMapping
			$deviceMapping.DeviceName = $disk.DeviceName
			$deviceMapping.Ebs = $volume

			$blockDeviceMapping += $deviceMapping
			
			
			
		}
		$scriptObj["BlockDeviceMapping"] = $blockDeviceMapping
		
	}
	catch {
		$Log.Error("$_.Exception.GetType().FullName, $_.Exception.Message")
		exit
	}
}