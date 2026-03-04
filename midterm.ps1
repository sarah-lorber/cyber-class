function Challenge2() {
$table = @()
$list = Get-Content C:\Users\champuser\CyberClass\access.log
for ($i = 0; $i -lt $list.Length; $i++) { 
$line = ($list[$i] -Split(' '));
$table += [pscustomobject]@{"IP" = $line[0];
                            "Time" = $line[3];
                            "Method" = $line[5];
                            "Page" = $line[6];
                            "Protocol" = $line[7];
                            "Response" = $line[8];
                            "Referrer" = $line[10];
                                    }}
$table
}


function Challenge1(){

$page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.6/IOC.html

$trs = $page.ParsedHtml.body.getElementsByTagName("tr")


$FullTable = @()
for ($i = 1; $i -lt $trs.length; $i++){
$tds = $trs[$i].getElementsByTagName("td")
$FullTable += [PSCustomObject]@{"Pattern" = $tds[0].innerText;
                                "Description" = $tds[1].innerText;
                                }

}
return $FullTable
}

function Challenge3 ($indicators, $events) {
for ($i = 0; $i -lt $indicators.length; $i++){
$filteredEvents += $events | Where-Object {$_.Page -match $indicators[$i].Pattern}
Write-Host $indicators[$i].Pattern}
return $filteredEvents}

$indicators = Challenge1
$events = Challenge2

$endResult = Challenge3 $indicators $events
$endResult | Format-Table | Out-String