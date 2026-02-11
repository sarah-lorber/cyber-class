function gatherClasses(){

$page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.43/Courses2026SP.html

$trs = $page.ParsedHtml.body.getElementsByTagName("tr")

$FullTable = @()
for ($i = 1; $i -lt $trs.length; $i++){
$tds = $trs[$i].getElementsByTagName("td")
$Times = $tds[5].innerText.split("-")
$FullTable += [PSCustomObject]@{"Class Code" = $tds[0].innerText;
                                "Title" = $tds[1].innerText;
                                "Days" = $tds[4].innerText;
                                "Time Start" = $Times[0];
                                "Time End" = $Times[1];
                                "Instructor" = $tds[6].innerText;
                                "Location" = $tds[9].innerText;}
                                }
return $FullTable
}

function daysTranslator($FullTable){
for($i=0; $i -lt $FullTable.length; $i++) {
$days = @()
if($FullTable[$i].Days -ilike "M*"){$days += "Monday"}

if($FullTable[$i].Days -ilike "*T[TWF]*"){$days += "Tuesday"}
ElseIf($FullTable[$i].Days -ilike "T"){$days += "Tuesday"}

if($FullTable[$i].Days -ilike "*W*"){$days += "Wednesday"}
if($FullTable[$i].Days -ilike "*TH*"){$days += "Thursday"}
if($FullTable[$i].Days -ilike "*F*"){$days += "Friday"}
$FullTable[$i].Days = $days
}
return $FullTable
}