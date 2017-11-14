<###########################################################
### Logging Example
###########################################################

### Load Class Module for Logging
using module "D:\Scripts\Modules\WebtoolLog\WebtoolLog.psm1"
### Initiate Loging from Source Parent Script
$Log = [WebtoolLog]::new("$(Split-Path $MyInvocation.ScriptName -Leaf)")

function Template{
	$Log.Title("$($PSCommandPath)  $($MyInvocation.MyCommand.Name)")
	#######################################################
	# Log Template
	#######################################################

	try {
		$Log.Info("info")
		$Log.Error("error")
		$Log.Invoke("dir")
	}
	catch {
		$ErrorMessage = $_.Exception.Message | Out-String
		$FailedItem = $_.Exception.ItemName | Out-String
		$Log.Error("Failed Item: $($FailedItem)")
		$Log.Error("Error Message: $($ErrorMessage)")
	}
}
#>


class WebtoolLog
{
    [string]$Folder
    [string]$File

    [string]$Script
    [string]$Name
	
    WebtoolLog([string]$ScriptName)
    {
        
        $this.Script = $ScriptName -replace ".ps1", ""
        $this.Folder = "D:\Logs\$($this.Script)"
        $this.Name = "$($this.Script)$(Get-Date -Format yyyyMMdd-HHmmss).log"
        $this.File   = "$($this.Folder)\$($this.Name)"

        New-Item "$($this.Folder)" -Type Directory -Force
    }  	

    [string] TimeStamp()
    {
        return $(Get-Date -Format "yyyyMMdd HH:mm:ss:fff")
    }


    Invoke([string] $message)
    {
       $output = "[$($this.TimeStamp())] [INVOKE  ] $message" 
       $output | Out-File -FilePath $this.File -Append
       $output | Out-Host
	   
	   try{
			$messageOutput = Invoke-Expression $message | Out-String
			if ( -Not ([string]::IsNullOrWhiteSpace($messageOutput))) {                       
				$this.Output($messageOutput)          
			}
		}
		catch{
			$ErrorMessage = $_.Exception.Message | Out-String
			$FailedItem = $_.Exception.ItemName | Out-String
			$this.Error("Failed Item: $($FailedItem)")
			$this.Error("Error Message: $($ErrorMessage)")
		}
    }
    Critical([string] $message)
    {
       $output = "[$($this.TimeStamp())] [CRITICAL] $message" 
       $output | Out-File -FilePath $this.File -Append
       #$output | Out-Host
       Write-Host $output -foregroundcolor "Red"
    }

    Error([string] $message)
    {
       $output = "[$($this.TimeStamp())] [ERROR   ] $message" 
       $output | Out-File -FilePath $this.File -Append
       #$output | Out-Host
       Write-Host $output -foregroundcolor "Red"
    }

    Info([string] $message)
    {
       $output = "[$($this.TimeStamp())] [INFO    ] $message" 
       $output | Out-File -FilePath $this.File -Append
       $output | Out-Host
    }
	
	Output([string] $message)
	{
	   $output = "[$($this.TimeStamp())] [OUTPUT  ]`r`n$message" 
       $output | Out-File -FilePath $this.File -Append
       $output | Out-Host 
	}
	
	Remote([string] $message)
    {
       $output = "[$($this.TimeStamp())] [REMOTE  ]`r`n$message" 
       $output | Out-File -FilePath $this.File -Append
       $output | Out-Host
    }
	
    Subtitle([string] $message)
    {
       $output = "`r`n[  $message  ]" 
       $output | Out-File -FilePath $this.File -Append
       $output | Out-Host
    }

    Title([string] $message)
    {
       $output = "`r`n==================================`r`n#   $message `r`n==================================" 
       $output | Out-File -FilePath $this.File -Append
       $output | Out-Host
    }

	Warning([string] $message)
    {
       $output = "[$($this.TimeStamp())] [WARNING ] $message" 
       $output | Out-File -FilePath $this.File -Append
       #$output | Out-Host
       Write-Host $output -foregroundcolor "Yellow"
    }
	
}
