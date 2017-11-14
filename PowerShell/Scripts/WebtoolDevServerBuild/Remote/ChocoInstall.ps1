function ChocoInstall {
	"================================== `r`n"
	"$(Hostname): Choco Install Packages  `r`n"
	"================================== `r`n "
	#######################################################
	# Choco Install
	#######################################################	
	
	$chocoPackage = New-Object Collections.ArrayList
	$chocoPackage.Add("notepadplusplus")
	$chocoPackage.Add("visualstudio2017community")
	
	#$chocoPackage.Add("git")
	"`r`nchoco install git `r`n"
	choco install git -params '"/GitAndUnixToolsOnPath"' -y -force | Out-Null
	choco install git.install -params '"/GitAndUnixToolsOnPath"' -y -force | Out-Null
	
	
	ForEach ($item in $chocoPackage){
		"choco install $item `r`n"
		choco install $item -y | Out-Null
		"choco upgrade $item `r`n"
		choco upgrade $item -y | Out-Null
	}
}