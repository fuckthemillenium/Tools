function CreateWebtoolInstance(){
	$Log.Title("$($PSCommandPath)  $($MyInvocation.MyCommand.Name)")	
	
	$Obj["ImageName"]   	= "WINDOWS_2016_BASE"
	$Obj["ImageID"] 		= (Get-EC2ImageByName -Name "$($Obj["ImageName"])" -Region "$($Obj["Region"])" ).ImageID
	$Obj["InstanceType"] 	= "m4.xlarge"
	$Obj["KeyName"]         = "DevOps"
		
	###################################################
	### BlockDeviceMapping 
	###################################################

	#Define the volume properties 
	$volume = New-Object Amazon.EC2.Model.EbsBlockDevice
	$volume.VolumeSize = 100
	$volume.VolumeType = 'gp2'
	$volume.DeleteOnTermination = $true
	$deviceMapping = New-Object Amazon.EC2.Model.BlockDeviceMapping
	$deviceMapping.DeviceName = '/dev/sda1'
	$deviceMapping.Ebs = $volume

	#Define the volume properties 
	$volume2 = New-Object Amazon.EC2.Model.EbsBlockDevice
	$volume2.VolumeSize = 200
	$volume2.VolumeType = 'gp2'
	$volume2.DeleteOnTermination = $true
	$deviceMapping2 = New-Object Amazon.EC2.Model.BlockDeviceMapping
	$deviceMapping2.DeviceName = 'xvdb'
	$deviceMapping2.Ebs = $volume2
	
	#BlockDeviceMapping
	$blockDeviceMapping = @()
	$blockDeviceMapping += $deviceMapping
	$blockDeviceMapping += $deviceMapping2



    #UserData
    $Scripts = "<powershell>
Enable-PSRemoting -SkipNetworkProfileCheck -Force
Set-NetFirewallRule -Name `"WINRM-HTTP-In-TCP-PUBLIC`" -RemoteAddress Any
</powershell>"
    $UserData = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($Scripts))
    

	###################################################
	### New-EC2Instance 
	###################################################	
	$Log.Info("New-EC2Instance -ImageId $($Obj["ImageID"]) -Region $($Obj["Region"]) -InstanceType $($Obj["InstanceType"]) -SubnetId $($Obj["SubnetId"]) -SecurityGroupId $($Obj["SecurityGroupId"]) -KeyName $($Obj["KeyName"]) -AssociatePublicIp $true -BlockDeviceMapping blockDeviceMapping -MinCount 1 -MaxCount 1 -UserData $UserData ")
    $Obj["InstanceID"] = (New-EC2Instance -ImageId "$($Obj["ImageID"])" -Region "$($Obj["Region"])" -InstanceType "$($Obj["InstanceType"])" -SubnetId "$($Obj["SubnetId"])" -SecurityGroupId "$($Obj["SecurityGroupId"])" -KeyName "$($Obj["KeyName"])" -AssociatePublicIp $true -BlockDeviceMapping $blockDeviceMapping -MinCount 1 -MaxCount 1 -UserData $UserData).Instances.InstanceID

	$timer = 0
	do {
		Start-Sleep -s "60"
		$timer += 1
		$Obj["InstanceState"] = (Get-EC2Instance -InstanceId $Obj["InstanceID"] -Region $Obj["Region"] ).Instances.State.Name | Select-Object -ExpandProperty "Value"
		$Log.Info("Instance ID:$($Obj["InstanceID"]) State:$($Obj["InstanceState"]) Time Elapsed: $($timer) minute(s)")
		if ( ($Obj["InstanceState"] -ne "pending") -Or ($Obj["InstanceState"] -ne "running") ) {
			break;
		}
	} until ( $Obj["InstanceState"] -eq "running" )
	
	###################################################
	### Tag Instance 
	###################################################
	$Log.Info("Tagging Instance ID:$($Obj["InstanceID"])")
	$tag = New-Object Amazon.EC2.Model.Tag
	$tag.Key = "Name"
	$tag.Value = "DevOps Webtools - $($Obj["Environment"])"
	New-EC2Tag -Resource $Obj["InstanceID"] -Tag $tag -Region $Obj["Region"]

	###################################################
	### Tag Volume
	###################################################
	$Log.Info("Tagging associated volumes to Instance ID:$($Obj["InstanceID"])")	
	$volumeIds = @()
	(Get-EC2Instance -InstanceId $Obj["InstanceID"] -Region $Obj["Region"]).Instances.BlockDeviceMappings.Ebs.VolumeId | ForEach-Object -Process {
		$volumeIds += "$_"
	}
	$tag = New-Object Amazon.EC2.Model.Tag
	$tag.Key = "Name"
	$tag.Value = "$($Obj["InstanceID"])"
	New-EC2Tag -Resource $volumeIds -Tag $tag -Region $Obj["Region"]
	ForEach ( $volumeId in $volumeIds ){
		$Log.Info("Tagging volume:$($volumeId) to Instance ID:$($Obj["InstanceID"])")
	}
}