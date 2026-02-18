<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>

function checkPassword($password){
if ($password.length -lt 6){Write-Host "length is bad"
return $false}
if ($password -notlike "*[0-9]*") {Write-Host "number not found"
return $false}
if (($password -notlike "*[A-Z]*") -and ($password -notmatch "*[a-z]*")) {Write-Host "letter not found"
return $false}
if ($password -notlike "*[`#`^`!`@`$`%`&`*]*") {Write-Host "char not found"
return $false}
return $true
}

<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}