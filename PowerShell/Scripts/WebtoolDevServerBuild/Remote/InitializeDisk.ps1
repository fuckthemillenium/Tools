
function InitializeDisk{
	"================================== `r`n"
	"$(Hostname): Initialize-Disk`r`n"
	"================================== `r`n"
	if ( -Not (Test-Path -Path "D:")){
		"D: drive does not exist. Initialize-Disk `r`n"
	   $numberOfflineDrive = (Get-Disk | where-object IsSystem -eq $False | Measure).Count
	   if ($numberOfflineDrive -eq 1){
			$disk = (Get-Disk | where-object IsSystem -eq $False)
			Initialize-Disk $($disk.Number) –PartitionStyle GPT
			Set-Disk -Number $($disk.Number) -IsOffline $False
			New-Partition -UseMaximumSize  –DiskNumber $($disk.Number) -DriveLetter D
			Format-Volume –DriveLetter D –FileSystem NTFS
			Label D: DevOps
	   }
	} else {
		"D: drive exist. `r`n"
	}
}