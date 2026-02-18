$scraped_page = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.43/ToBeScraped.html

#$scraped_page.Links | Select-Object -Property outerText, href
#$h2s = $scraped_page.ParsedHtml.body.getElementsByTagName("h2") | Select-Object -Property outerText
#$h2s

$div1s = $scraped_page.ParsedHtml.body.getElementsByTagName("div") | 
where {$_.getAttributeNode("class").value -ilike "div-1"} | select innerText
$div1s