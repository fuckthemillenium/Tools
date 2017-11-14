function NewItemDirectory{
	param(
		[switch] $Dev
	)
	
	$Log.Title("$($PSCommandPath)  $($MyInvocation.MyCommand.Name)")
	#######################################################
	# Create Directory
	#######################################################
	
	if ($Dev){
		$Log.Invoke("New-Item -Type Directory -Force D:\Codes\Projects | Out-Null")
		$Log.Invoke("New-Item -Type Directory -Force D:\Codes\Templates\ItemTemplates | Out-Null")
		$Log.Invoke("New-Item -Type Directory -Force D:\Codes\Templates\ProjectTemplates | Out-Null")
		$Log.Invoke("New-Item -Type Directory -Force D:\Configuration | Out-Null")
	}
	$Log.Invoke("New-Item -Type Directory -Force D:\Download | Out-Null")
	$Log.Invoke("New-Item -Type Directory -Force D:\Logs | Out-Null")
	$Log.Invoke("New-Item -Type Directory -Force D:\WebApp | Out-Null")
	
}