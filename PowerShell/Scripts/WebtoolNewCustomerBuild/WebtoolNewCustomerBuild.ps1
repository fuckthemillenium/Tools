<#######################################################################
.SYNOPSIS
    . NSPOS AWS - New Customer Build
.DESCRIPTION
.PARAMETER Path
.EXAMPLE
    .\WebtoolNewCustomerBuild.ps1 [[-Region] <string>]
.NOTES
    Author:         Khanh Tran
    Design Process: Chris Ferris
    Date:           10/12/2017
#######################################################################>


param(
    # AwsName
    [Parameter(Mandatory=$True)]
    [string]$AwsName, 

    # CustomerName
    [Parameter(Mandatory=$True)]
    [string]$CustomerName,

    # CustomerId
    [Parameter(Mandatory=$True)]
    [string]$CustomerId,

    # CustomerSize
    [Parameter(Mandatory=$True)]
    [ValidateSet("Small","Medium", "Large", "xLarge")] 
    [string]$CustomerSize,

    # Aws Region
    [Parameter(Mandatory=$True)]
    [ValidateSet("us-east-1", "eu-west-1", "ap-southeast-2")] 
    [string]$Region,

    # Environment
    [Parameter(Mandatory=$True)]
    [ValidateSet("Production", "Implementation")] 
    [string]$Environment
)


<#######################################################################
	Load Script Library
#######################################################################>
. "$PSScriptRoot\Library\LoadLibrary.ps1"
$Log.Title("$($PSCommandPath)  $($MyInvocation.MyCommand.Name)")
<#######################################################################
	Initiate Global $scriptObj
#######################################################################>	
$scriptObj = @{}
$scriptObj["AwsName"]       = "$AwsName"
$scriptObj["CustomerId"]    = "$CustomerId"
$scriptObj["CustomerSize"]  = "$CustomerSize"
$scriptObj["Region"]        = "$Region"
$scriptObj["Environment"]   = "$Environment"


GetAmi
GetSubnetId
GetSecurityGroups
GetCustomerSize

CreateInstance
GetIpAddress
TagInstance





<#######################################################################
	Script Ended, created summary of results
#######################################################################>	
$Log.Subtitle("Summary of Result")
$Log.Output("$($scriptObj | Out-String)")
#$Log.Output("$($scriptObj["BlockDeviceMapping"] | Out-String)")
$Log.Title("$($MyInvocation.MyCommand.Name) COMPLETED")
