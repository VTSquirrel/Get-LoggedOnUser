# Get-LastLoggedOnUser
Get the username of the user currently logged in to a target computer

## Usage
```
Import-Module .\Get-LastLoggedOnUser.ps1

Get-LoggedOnUser -ComputerName DEVICE_NAME


Computer     User      
--------     ----      
DEVICE_NAME  ExampleUser
```

```
Get-LoggedOnUser -ComputerName DEVICE_1,DEVICE_2 -OutputToHost $true
Checking DEVICE_1 (1 of 2)... Offline
Checking DEVICE_2 (2 of 2)... Online
	Getting logged on user... Done

Computer     User             
--------     ----             
DEVICE_1     Unable to Connect
DEVICE_2     DOMAIN\Example_User   
```
