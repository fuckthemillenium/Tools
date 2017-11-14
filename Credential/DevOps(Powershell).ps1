 Install-Package -Name AWSPowerShell -Force
 Install-Package -Name AWSPowerShell.NetCore -AllowClobber -Force
 
echo $profile C:\Users\Administrator\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

Set-AWSCredentials -AccessKey AKIAJ7KX7KJ5P4TAZJVQ -SecretKey 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 -StoreAs DevOps
Initialize-AWSDefaults -ProfileName DevOps -Region us-east-1


