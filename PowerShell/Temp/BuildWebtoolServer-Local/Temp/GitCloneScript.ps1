try{
	Test-Path -Path "D:"
}
catch{
	$numberOfflineDrive = (Get-Disk | where-object IsSystem -eq $False | Measure).Count
	if ($numberOfflineDrive -eq 1){
		$disk = (Get-Disk | where-object IsSystem -eq $False)
		Initialize-Disk $($disk.Number) –PartitionStyle GPT
		Set-Disk -Number $($disk.Number) -IsOffline $False
		New-Partition -UseMaximumSize  –DiskNumber $($disk.Number) -DriveLetter D
		Format-Volume –DriveLetter D –FileSystem NTFS
		Label D: Ops
	}
}

iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco upgrade chocolatey -y
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
git clone https://ops-gitlab.ns-pos.com/webtoolv3/Scripts.git
