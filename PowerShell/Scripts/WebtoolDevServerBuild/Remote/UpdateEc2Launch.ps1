function UpdateEc2Launch{
	"================================== `r`n"
	"$(Hostname): Update Ec2Launch Window 2016 `r`n"
	"================================== `r`n"
	#######################################################
	# Update Ec2Launch Window 2016
	#######################################################

	try {
		"DownloadFile EC2-Windows-Launch.zip to D:\Download\EC2-Windows-Launch.zip `r`n"
		$source = "https://s3.amazonaws.com/ec2-downloads-windows/EC2Launch/latest/EC2-Windows-Launch.zip"
		$destination = "D:\Download\EC2-Windows-Launch.zip"
		(New-Object System.Net.WebClient).DownloadFile($source, $destination)
		
		"DownloadFile install.ps1 to D:\Download\install.ps1 `r`n"
		$source = "https://s3.amazonaws.com/ec2-downloads-windows/EC2Launch/latest/install.ps1"
		$destination = "D:\Download\install.ps1"
		(New-Object System.Net.WebClient).DownloadFile($source, $destination)
	
		Invoke-Expression "D:\Download\install.ps1"
	}
	catch {
		$ErrorMessage = $_.Exception.Message | Out-String
		$FailedItem = $_.Exception.ItemName | Out-String
		"Failed Item: $($FailedItem) `r`n"
		"Error Message: $($ErrorMessage) `r`n"
	}
}