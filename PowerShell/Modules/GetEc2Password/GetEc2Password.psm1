class GetEc2Password{
	$Password = $null

	GetEc2Password([String]$InstanceID, [String]$Region)
	{
		[String] $pemFile = $null

		Switch ($Region){
				"us-west-1" {
					$pemFile = "D:\Credential\DevOps(California).pem"
				}
				"us-east-1" {
					$pemFile = "D:\Credential\DevOps(Virginia).pem"
				}
				Default { $pemFile = $null }
			}
		$timer = 0	
		do{
			$timer++
			try {	
				$This.Password = (Get-EC2PasswordData -InstanceId "$InstanceID" -PemFile "$pemFile" -Region "$Region")
				Break;
			} catch {
				"password not available, try again in 60 seconds.. time elasped: $timer"
			}
			Start-Sleep -s 60
		} until (($This.Password) -Or ($timer -gt 10))
	}
}