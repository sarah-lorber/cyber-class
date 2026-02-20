. (Join-Path $PSScriptRoot apachelogs2.ps1)
. (Join-Path $PSScriptRoot ../ lumu/Event-Logs.ps1)
. (Join-Path $PSScriptRoot ../ Users.ps1)
. (Join-Path $PSScriptRoot processmanagement.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display last 10 apache logs`n"
$Prompt += "2 - Display last 10 failed logins`n"
$Prompt += "3 - Display at risk users`n"
$Prompt += "4 - Start Chrome`n"
$Prompt += "5 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $lastTenLogs = logParse
        Write-Host ($lastTenLogs | Select-Object -last 10 | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $failedLogins = getFailedLogins 14
        Write-Host ($failedLogins | Select-Object -last 10 | Format-Table | Out-String)
    }


    elseif($choice -eq 3){
    $theAtRiskUsers = getAtRiskUsers 14
    Write-Host ($theAtRiskUsers | Select-Object Name | Format-Table | Out-String)
    }
    
  
    elseif($choice -eq 4){
    $chrome = doChrome
    }


    
    else{Write-Host "That's not an acceptable input, please try again." | Out-String}


}