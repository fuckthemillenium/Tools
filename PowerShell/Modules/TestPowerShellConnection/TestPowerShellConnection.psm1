class TestPowerShellConnection
{
<#
Usage:
	$connection = New-Object TestPowerShellConnection
	$connection.Test($computerNames, $Credential)
	$connection.Status
#>
	$Status = @()

	TestPowerShellConnection(){
		Set-Item WSMan:\localhost\Client\TrustedHosts * -Force
	}
		
	Test([String[]]$ComputerName, $Credential)
    {
		Foreach ($CurrentComputerName in $ComputerName) {
			$CurrentStatus = [Ordered]@{
				"ComputerName"      = $CurrentComputerName;
				"Ping" 				= $false;
				"TestConnection" 	= $false;
				"TestWSMan"			= $false;
				"PSSession"         = $false;
			}
			
			switch("x"){
				"x" { <# Test Ping #>
					$Timeout = 100
					$Ping = New-Object System.Net.NetworkInformation.Ping
					$Response = $Ping.Send($CurrentComputerName,$Timeout)
					$CurrentStatus.Ping = $Response.Status
				}
				" " { <# Test-Connection #>
						$CurrentStatus.TestConnection = $(Test-Connection -Source $CurrentComputerName -ComputerName $CurrentComputerName -Credential $credential -Count 1)
				}
			
				"x" { <# Test-WSMan port 5985#>
						if (Test-WSMan -ComputerName $CurrentComputerName){
							$CurrentStatus.TestWSMan = $true
						}
					}
					
				"x" { <# New-PSSession port 5985 #>
					$session = New-PSSession $CurrentComputerName -ErrorAction SilentlyContinue -Credential $credential
					if ($session -is [System.Management.Automation.Runspaces.PSSession]){
						$CurrentStatus.PSSession = $true
					}
				}
			}
			
			$psobject = new-object psobject -Property $CurrentStatus
			$This.Status += $psobject
		}
    } 
}