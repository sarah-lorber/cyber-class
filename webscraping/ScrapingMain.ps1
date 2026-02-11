. (Join-Path $PSScriptRoot ScrapingChamplain.ps1)

clear

$tableRecords = gatherClasses
$tableUpdate = daysTranslator $tableRecords
#Write-Host ($tableUpdate | Format-Table -AutoSize | Out-String)

#$tableUpdate | Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End" | 
#    Where-Object {$_."Instructor" -ilike "Furkan*"}

#$tableUpdate | Where-Object {($_.Location -ilike "FREE 105") -and ($_.days -contains "Wednesday")} |
#    Sort-Object -Descending "Time Start" |
#    Select-Object "Time Start", "Time End", "Class Code"

$ITSInstructors = $tableUpdate | Where-Object { ($_."Class Code" -ilike "SYS*") -or `
                                                ($_."Class Code" -ilike "NET*") -or `
                                                ($_."Class Code" -ilike "SEC*") -or `
                                                ($_."Class Code" -ilike "FOR*") -or `
                                                ($_."Class Code" -ilike "CSI*") -or `
                                                ($_."Class Code" -ilike "DAY*") } `
                               | Select-Object "Instructor" `
                               | Sort-Object "Instructor" -unique
$ITSInstructorsCorrect = $ITSInstructors | Where-Object {$_."Instructor" -notlike "*[0-9]*"}
#$ITSInstructorsCorrect

$tableUpdate | Where-Object {$_.Instructor -in $ITSInstructorsCorrect.Instructor} `
| Group-Object "Instructor" | Select-Object -Property Count, Name | Sort-Object Count -Descending