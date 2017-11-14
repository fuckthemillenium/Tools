function SetExecutionPolicy{
	"================================== `r`n"
	"$(Hostname): Set-ExecutionPolicy Unrestricted -Force `r`n"
	"================================== `r`n"
	Set-ExecutionPolicy Unrestricted -Force
    "Get-ExecutionPolicy: $(Get-ExecutionPolicy) `r`n"
	if("$(Get-ExecutionPolicy)" -ne "Unrestricted"){
		"Execution Policy is $(Get-ExecutionPolicy) `r`n"
		"Please set `"Set-ExecutionPolicy Unrestricted`" before continue `r`n"
	}
}