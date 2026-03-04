function readConfiguration{
$textConfig = Get-Content C:\Users\champuser\CyberClass\seraru\configuration.txt
$tableConfig = @()
$tableConfig += [pscustomobject]@{"Days" = $textConfig[0];
                            "ExecutionTime" = $textConfig[1];
                            
                                    }
return $tableConfig
}

function changeConfiguration{
$PromptDays = "Enter the number of days for which logs will be obtained:"
Write-Host $PromptDays | Out-String
$daysChoice = Read-Host
if ($daysChoice -match '\D+') {Write-Host "Please enter digits only."
return $false}
$PromptTime = "Enter the time script will be executed:"
Write-Host $PromptTime | Out-String
$timeChoice = Read-Host
if ($timeChoice -notmatch '[0-9]:[0-9][0-9] [AP]M') {Write-Host "That's not a valid time."
return $false}
$newConfig = @()
$newConfig += [pscustomobject]@{"Days" = $daysChoice;
                            "ExecutionTime" = $timeChoice;}
$daysChoice | Out-File -FilePath configuration.txt
$timeChoice | Out-File -FilePath configuration.txt -append
return $true
}


function configurationMenu{
$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Show configuration`n"
$Prompt += "2 - Change configuration`n"
$Prompt += "3 - Exit`n"

$operation = $true

cd $PSScriptRoot

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 3){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $tableConfig = readConfiguration
        Write-Host ($tableConfig | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $changedConfig = changeConfiguration
        if ($changedConfig -eq $true) {Write-Host "Configuration Changed" | Out-String}
        else {Write-Host "Configuration did not change, please try again." | Out-String}
    }
    
    else{Write-Host "That's not an acceptable input, please try again." | Out-String}
}
}