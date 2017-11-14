	#######################################################
	# Server Configuration
	#######################################################

function ChangePassword(){
	if ($NewPassword){
		"Change password `r`n"
		$decodedpassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::StringToBSTR($NewPassword))
		$user = [adsi]"WinNT://localhost/administrator,user"
		$user.SetPassword($decodedpassword)
		$user.SetInfo()
		
	} else {
		"No NewPassword entered, no password change.`r`n"
	}
}
