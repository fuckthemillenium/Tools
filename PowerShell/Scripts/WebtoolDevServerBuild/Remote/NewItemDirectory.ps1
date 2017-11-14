function NewItemDirectory{
	param(
		[switch] $Dev
	)
	
	"================================== `r`n"
	"$(Hostname): New-Item Directory `r`n"
	"================================== `r`n"
	
	#######################################################
	# Create Directory
	#######################################################

	$directory = New-Object Collections.ArrayList
	
	$directory.Add("D:\Download")
	$directory.Add("D:\Logs")
	$directory.Add("D:\WebApp")

	if ($Dev){
		$directory.Add("D:\Codes\Projects")
		$directory.Add("D:\Codes\Templates\ItemTemplates")
		$directory.Add("D:\Codes\Templates\ProjectTemplates")		
		$directory.Add("D:\Credential")
	}
	"`r`n"
	ForEach ($item in $directory){
		"New-Item -Type Directory -Force $item `r`n"
		New-Item -Type Directory -Force $item | Out-Null
	}
	
}