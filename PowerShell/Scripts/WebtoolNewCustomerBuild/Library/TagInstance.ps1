function TagInstance(){
	$Log.Subtitle("$($MyInvocation.MyCommand.Name)")
	try {
		$tags = @(	@{ Key="Name"; 				Value="$($scriptObj['AwsName'])" },`
					@{ Key="Customer ID";		Value="$($scriptObj['CustomerId'])"},`					
					@{ Key="Environment";		Value="$($scriptObj['Environment'])"}`
				)
		New-EC2Tag -ResourceId $scriptObj["InstanceId"] -Tags $tags -Region $scriptObj["Region"]
		$Log.Info("success created tags for new instance: $($scriptObj["InstanceId"])")
	}
	catch {
		$Log.Error("$_.Exception.GetType().FullName, $_.Exception.Message")
	}
}