function GetRoute53(){
<#
    Description:
        Get Route53 information from instances IDs.  These info will be used to edit the route53

    Usage Example:
        $instanceIDs =  New-Object System.Collections.Generic.List[System.Object]
        $instanceIDs.Add("i-0de684a0c4e3a1b5c")
        $instanceIDs.Add("i-06d8cb0c607b329a2")

        GetRoute53 -InstanceIDs $InstanceIDs
#>
	param ( [Parameter(Mandatory=$true)] [String[]]$InstanceIDs )
	
   
	# Create a array of region
	$Regions =  New-Object System.Collections.Generic.List[System.Object]
	$RegionS.Add("us-east-1")			# Virginia
	$RegionS.Add("eu-west-1")     	# Ireland
	$RegionS.Add("ap-southeast-2")	# Sydney
		
	# Single ec2 request call on each regions
	$ec2Instances = New-Object System.Collections.Generic.List[System.Object]
	foreach ($Region in $RegionS){
		$ec2Instances.Add($(Get-EC2Instance -Region $Region))
	}

	
	# Single route53 request call
	$hostZoneID = "Z3HVIQEH4U3QHK"
	$allRoute53s = @()
	$nextIdentifier = $null
	$nextType = $null
	$nextName = $null
	do 
	{
		$recordSets = Get-R53ResourceRecordSet -HostedZoneId $hostZoneID  `
											  -StartRecordIdentifier $nextIdentifier `
											  -StartRecordName $nextName `
											  -StartRecordType $nextType
		if ($recordSets.IsTruncated)
		{
			$nextIdentifier = $recordSets.NextRecordIdentifier
			$nextType = $recordSets.NextRecordType
			$nextName = $recordSets.NextRecordName
		}

		foreach ($resourceRecordSet in $recordSets.ResourceRecordSets){
			$allRoute53s += $resourceRecordSet
		}
	} while ($recordSets.IsTruncated)


	# compare instance ip with route53
	foreach ($ec2Instance in $ec2Instances){
		foreach ( $instanceID in $instanceIDs ) {
			try{
				$ec2 = $ec2Instance.Instances | Where-Object {$_.InstanceId -eq $instanceID}
				$privateIp = $ec2.PrivateIpAddress 

				$matchedRoute53s = $allRoute53s | Where-Object { (($_.Type.Value -eq "A" -or "CNAME") -And ($_.ResourceRecords.Value -eq $privateIp ))}
                foreach ($matchedRoute53 in $matchedRoute53s){
					DeleteRoute53 $matchedRoute53
                }
			} catch { }
		}
	}
	
}

function DeleteRoute53(){
	param ( [Parameter(Mandatory=$true)] $route53 )
	"Deleting:  $($route53.ResourceRecords.Value)  $($route53.Type)  $($route53.TTL)  $($route53.Name)" 
	
	$hostZoneID = "Z3HVIQEH4U3QHK"
	$change = New-Object Amazon.Route53.Model.Change
	$change.Action = "DELETE"
	$change.ResourceRecordSet = New-Object Amazon.Route53.Model.ResourceRecordSet
	$change.ResourceRecordSet.Name = "$($route53.Name)"           # abc.retailanywhere.com
	$change.ResourceRecordSet.Type = "$($route53.Type)"			  # A
	$change.ResourceRecordSet.TTL = "$($route53.TTL)"
	$change.ResourceRecordSet.ResourceRecords.Add(@{Value="$($route53.ResourceRecords.Value)"})

    $params = @{
        HostedZoneId="$hostZoneID"
	    ChangeBatch_Comment="DevOps Automation to delete: Route53 after terminating a clone."
	    ChangeBatch_Change=$change
    }

     #Edit-R53ResourceRecordSet @params
}


$instanceIDs =  New-Object System.Collections.Generic.List[System.Object]
$instanceIDs.Add("i-0de684a0c4e3a1b5c")
$instanceIDs.Add("i-06d8cb0c607b329a2")



GetRoute53 -InstanceIDs $InstanceIDs