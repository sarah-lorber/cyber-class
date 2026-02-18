. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Log.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - Exit`n"
$Prompt += "0 - List at Risk Users`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 9){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"
        $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"

        $doesUserExist = checkUser $name
        if ($doesUserExist) {Write-Host "User: $name already exists." | Out-String}
        else {
        $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
        $plainpassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
        $passwordIsFine = checkPassword $plainpassword
        $password = ConvertTo-SecureString $plainpassword -AsPlainText -Force
        Write-Host $plainpassword
        Write-Host $passwordIsFine | Out-String
        if (-not $passwordIsFine) {Write-Host "That is not an acceptable password.  An acceptable password has at least 1 special character, 1 number, and 1 letter and is at least 6 characters long." | Out-String}
        else {
                createAUser $name $password
        Write-Host "User: $name is created." | Out-String}
    }}


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        # TODO: Check the given username with the checkUser function.
        $doesUserExist = checkUser $name
        if (-not $doesUserExist) {Write-Host "User: $name is not a user on this system." | Out-String}
        else {
        removeAUser $name

        Write-Host "User: $name Removed." | Out-String}
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        # TODO: Check the given username with the checkUser function.
        $doesUserExist = checkUser $name
        if (-not $doesUserExist) {Write-Host "User: $name is not a user on this system." | Out-String}
        else {
        enableAUser $name

        Write-Host "User: $name Enabled." | Out-String}
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        # TODO: Check the given username with the checkUser function.
        $doesUserExist = checkUser $name
        if (-not $doesUserExist) {Write-Host "User: $name is not a user on this system." | Out-String}
        else {
        disableAUser $name

        Write-Host "User: $name Disabled." | Out-String}
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        # TODO: Check the given username with the checkUser function.
        $doesUserExist = checkUser $name
        if (-not $doesUserExist) {Write-Host "User: $name is not a user on this system." | Out-String}
        else {
        $daysPrompt = Read-Host "How many days back do you want to search: "
        $userLogins = getLogInAndOffs $daysPrompt
        # TODO: Change the above line in a way that, the days 90 should be taken from the user

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)}
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        # TODO: Check the given username with the checkUser function.
        $doesUserExist = checkUser $name
        if (-not $doesUserExist) {Write-Host "User: $name is not a user on this system." | Out-String}
        else {
        $daysPrompt = Read-Host "How many days back do you want to search"
        $userLogins = getFailedLogins $daysPrompt
        # TODO: Change the above line in a way that, the days 90 should be taken from the user

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)}
    }
    elseif($choice -eq 0){
    $daysPrompt = Read-Host "How many days back do you want to search"
    $atRiskUsers = getAtRiskUsers $daysPrompt
    Write-Host ($atRiskUsers | Out-String)
    }
    else{Write-Host "That's not an acceptable input, please try again." | Out-String}


    # TODO: Create another choice "List at Risk Users" that
    #              - Lists all the users with more than 10 failed logins in the last <User Given> days.  
    #                (You might need to create some failed logins to test)
    #              - Do not forget to update prompt and option numbers
    
    

    

}