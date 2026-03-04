function SendAlertEmail($Body){
$From = "sarah.lorber@mymail.champlain.edu"
$To = "sarah.lorber@mymail.champlain.edu"
$Subject = "Look What I Made!"

$Password = Get-Content "C:\Users\champuser\CyberClass\seraru\file.txt" | ConvertTo-SecureString
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $From, $Password

Send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -SmtpServer "smtp.gmail.com" -port 587 -UseSsl -Credential $Credential
}