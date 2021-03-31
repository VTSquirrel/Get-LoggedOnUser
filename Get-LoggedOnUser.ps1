Function Get-LoggedOnUser{
     [CmdletBinding()]
     param
     (
         [Parameter()]
         [ValidateNotNullOrEmpty()]
         [string]$ComputerName = $env:COMPUTERNAME,
         [boolean] $OutputToHost = $false
     )
     $Result = New-Object System.Collections.Generic.List[System.Object]

     foreach ($comp in $ComputerName){
        if(Test-Connection $comp -Quiet -Count 1){
            $Result.Add([PSCustomObject]@{
                Computer = $comp
                User = (Get-WmiObject -Class win32_computersystem -ComputerName $comp).UserName
            })
        }else{
            $Result.Add([PSCustomObject]@{
                Computer = $comp
                User = "Unable to Connect"
            })
            if ($OutputToHost){
                Write-Host "Unable to establish remote connection to $comp" -ForegroundColor Red
            }
        }
     }
     
     if ($OutputToHost){
        $Result | ft -a
     }else{
        return $Result
     }
 }