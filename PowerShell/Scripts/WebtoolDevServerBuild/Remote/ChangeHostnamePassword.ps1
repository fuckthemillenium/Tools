function ChangeHostname(){
	if($NewHostName){
		"Change Hostname `r`n"
		Rename-Computer -NewName "$NewHostName"  -Restart -Force
	}

}