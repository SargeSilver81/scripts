$sourcePath = 'F:\DCIM\100D3200\'
$destPath = 'R:\'

Write-Host "setting temp drive"
$net = new-object -ComObject WScript.Network
$net.MapNetworkDrive("R:", "\\d.docs.live.net\FB814EDDAABC830D\RAW_Backup", $false, "gavargent@gmail.com", "OliviaJayn3")
#New-PSDrive -Name R -PSProvider FileSystem -Root "\\d.docs.live.net\FB814EDDAABC830D\RAW_Backup"

Write-Host "Selecting and copying files"
Get-ChildItem $sourcePath -Recurse -filter *.NEF | % {
    Write-Host "Copying: " $_.FullName
    Copy-Item $_.FullName -Destination $destPath -ErrorAction SilentlyContinue
}

Write-Host "Removing temp drive"
#Remove-PSDrive RAW_Backup
net use R: /delete
