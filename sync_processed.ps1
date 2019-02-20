$sourcePath = 'C:\Users\gavar\Pictures\Processed'
$destPath = 'P:\Processed'

Write-Host "## Sync Processed to SILVERNAS ##" -ForegroundColor Yellow
$Total = ( Get-ChildItem $sourcePath -Recurse | Measure-Object ).Count;
$lc = 0

Get-ChildItem $sourcePath -Recurse | % {
    ++$lc
    Write-Host "Copying ($lc/$Total): " $_.FullName
    Copy-Item $_.FullName -Destination $destPath -ErrorAction Continue
}

