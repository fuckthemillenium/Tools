$Obj = @{}
$Obj["Region"] = @{"N. Virginia" = "us-east-1"; "Ireland" = "eu-west-1"; "Sydney" = "ap-southeast-2"}

Foreach ($region in $($Obj["Region"])){
    $instances = (Get-Ec2Instance -Region $($region.Value))
}