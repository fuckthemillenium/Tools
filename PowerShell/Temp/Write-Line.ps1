function Write-Line(){
	param ([Parameter(Mandatory=$true)][string] $Message)
	Write-Output ("$($Message)`r`n")
}