function UpdateEc2Launch{
	$Log.Title("$($PSCommandPath)  $($MyInvocation.MyCommand.Name)")
	#######################################################
	# Update Ec2Launch Window 2016
	#######################################################

	try {
		$client = new-object System.Net.WebClient
		$Log.Info("DownloadFile EC2-Windows-Launch.zip to D:\Download\EC2-Windows-Launch.zip")
		$client.DownloadFile("https://s3.amazonaws.com/ec2-downloads-windows/EC2Launch/latest/EC2-Windows-Launch.zip", "D:\Download\EC2-Windows-Launch.zip")
		
		$Log.Info("DownloadFile install.ps1 to D:\Download\install.ps1")
		$client.DownloadFile("https://s3.amazonaws.com/ec2-downloads-windows/EC2Launch/latest/install.ps1", "D:\Download\install.ps1")
	
		$Log.Invoke("D:\Download\install.ps1")
	}
	catch {
		$ErrorMessage = $_.Exception.Message | Out-String
		$FailedItem = $_.Exception.ItemName | Out-String
		$Log.Error("Failed Item: $($FailedItem)")
		$Log.Error("Error Message: $($ErrorMessage)")
	}
}