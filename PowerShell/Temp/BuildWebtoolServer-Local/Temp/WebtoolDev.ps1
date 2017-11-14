Param(
    [Parameter(Mandatory = $true)][String]$NewHostName,
    [Parameter(Mandatory = $true)][String]$NewPassword
)


#######################################################
# Webtool : Dev Box Server Build
#
#######################################################
Set-ExecutionPolicy Unrestricted



#######################################################
# Initialize-Disk D
#######################################################
if (Test-Path -Path "D:"){
    "D: drive already exist"
}
else{
   $numberOfflineDrive = (Get-Disk | where-object IsSystem -eq $False | Measure).Count
   if ($numberOfflineDrive -eq 1){
        $disk = (Get-Disk | where-object IsSystem -eq $False)
        "Initialize-Disk $($disk.Number) –PartitionStyle GPT"
        Initialize-Disk $disk.Number –PartitionStyle GPT

        "Set-Disk -Number $($disk.Number) Online"
        Set-Disk -Number $disk.Number -IsOffline $False


       "New-Partition -UseMaximumSize  –DiskNumber $($disk.Number) -DriveLetter D"
        New-Partition -UseMaximumSize  –DiskNumber $($disk.Number) -DriveLetter "D"


        "Format-Volume –DriveLetter D –FileSystem NTFS"
        Format-Volume –DriveLetter "D" –FileSystem NTFS

        Label D: Ops
   }
}


#######################################################
# Create Directory
#######################################################
New-Item -Type Directory -Force D:\Codes\Projects
New-Item -Type Directory -Force D:\Codes\Templates\ItemTemplates
New-Item -Type Directory -Force D:\Codes\Templates\ProjectTemplates
New-Item -Type Directory -Force D:\Configuration
New-Item -Type Directory -Force D:\Download
New-Item -Type Directory -Force D:\Logs
New-Item -Type Directory -Force D:\WebApp


#######################################################
# Update Ec2Launch Window 2016
#######################################################
$client = new-object System.Net.WebClient
$client.DownloadFile("https://s3.amazonaws.com/ec2-downloads-windows/EC2Launch/latest/EC2-Windows-Launch.zip", "D:\Download\EC2-Windows-Launch.zip")
$client.DownloadFile("https://s3.amazonaws.com/ec2-downloads-windows/EC2Launch/latest/install.ps1", "D:\Download\install.ps1")
Invoke-Expression "D:\Download\install.ps1"



#######################################################
# Download and Install Chocolatey
#######################################################
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco upgrade chocolatey -y


#######################################################
# Install Notepad++
#######################################################
choco install notepadplusplus -y
choco upgrade notepadplusplus -y


#######################################################
# Install Git
#######################################################
choco install git.install -y
choco upgrade git.install -y
git config --global http.sslVerify false
git config --global user.name "KT"
git config --global user.email "khanh.v.tran@oracle.com"
#######################################################
# Git Clone
#######################################################
cd d:\
git clone https://34.200.121.245/webtoolv3/Scripts.git


#######################################################
# Install IIS
#######################################################
Install-WindowsFeature -name Web-Server -IncludeManagementTools


#######################################################
# Install Visual Studio Community
#######################################################
choco install visualstudio2017community -y
choco upgrade visualstudio2017community -y


#######################################################
# Time Zone  
#######################################################
Set-TimeZone -Name "Pacific Standard Time"


#######################################################
# Server Configuration
#######################################################
# Change Password
if ($NewPassword){
    $decodedpassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::StringToBSTR($NewPassword))
    $user = [adsi]"WinNT://localhost/administrator,user"
    $user.SetPassword($decodedpassword)
    $user.SetInfo()
}


#Change Hostname
if($NewHostName){
    Rename-Computer -NewName "$NewHostName"  -Restart -Force
}







