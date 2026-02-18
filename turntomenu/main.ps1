. (Join-Path $PSScriptRoot ../ apachelogs1.ps1)
. (Join-Path $PSScriptRoot ../ lumu/Event-Logs.ps1)
. (Join-Path $PSScriptRoot ../ Users.ps1)
. (Join-Path $PSScriptRoot ../ processmanagement.ps1)

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

        # TODO: Create a function called checkUser in Users that: 
        #              - Checks if user a exists. 
        #              - If user exists, returns true, else returns false
        # TODO: Check the given username with your new function.
        #              - If false is returned, continue with the rest of the function
        #              - If true is returned, do not continue and inform the user
        #
        $doesUserExist = checkUser $name
        if ($doesUserExist) {Write-Host "User: $name already exists." | Out-String}
        else {
        # TODO: Create a function called checkPassword in String-Helper that:
        #              - Checks if the given string is at least 6 characters
        #              - Checks if the given string contains at least 1 special character, 1 number, and 1 letter
        #              - If the given string does not satisfy conditions, returns false
        #              - If the given string satisfy the conditions, returns true
        # TODO: Check the given password with your new function. 
        #              - If false is returned, do not continue and inform the user
        #              - If true is returned, continue with the rest of the function
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


    
    else{Write-Host "That's not an acceptable input, please try again." | Out-String}


    # TODO: Create another choice "List at Risk Users" that
    #              - Lists all the users with more than 10 failed logins in the last <User Given> days.  
    #                (You might need to create some failed logins to test)
    #              - Do not forget to update prompt and option numbers
    
    # TODO: If user enters anything other than listed choices, e.g. a number that is not in the menu   
    #       or a character that should not be accepted. Give a proper message to the user and prompt again.
    

}