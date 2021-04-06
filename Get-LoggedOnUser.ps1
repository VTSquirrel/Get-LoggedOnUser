Function Get-LoggedOnUser{
     [CmdletBinding()]
     param
     (
         [Parameter()]
         [ValidateNotNullOrEmpty()]
         [string[]]$ComputerName = $env:COMPUTERNAME,
         [boolean] $OutputToHost = $false
     )
     $Result = New-Object System.Collections.Generic.List[System.Object]

     $Count = 1
     foreach ($comp in $ComputerName){
        if ($OutputToHost){Write-Host "Checking $comp ($Count of $($ComputerName.Count))... " -NoNewline}
        
        if(Test-Connection $comp -Quiet -Count 1){
            if ($OutputToHost){
                Write-Host "Online" -ForegroundColor Green
                Write-Host "`tGetting logged on user... " -NoNewline
            }

            try{
                $Result.Add([PSCustomObject]@{
                    Computer = $comp
                    User = (Get-WmiObject -Class win32_computersystem -ComputerName $comp -ErrorAction Stop).UserName
                })
            }catch{
                Write-Host "Failed" -ForegroundColor Red
                $Result.Add([PSCustomObject]@{
                    Computer = $comp
                    User = "Failed to Retrieve User"
                })
            }

            if ($OutputToHost){Write-Host "Done" -ForegroundColor Green}
        }else{
            $Result.Add([PSCustomObject]@{
                Computer = $comp
                User = "Unable to Connect"
            })
            if ($OutputToHost){
                Write-Host "Offline" -ForegroundColor Red
            }
        }
        $Count++
     }
     
     if ($OutputToHost){
        $Result | ft -a
     }else{
        return $Result
     }
 }
