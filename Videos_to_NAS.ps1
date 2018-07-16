 Write-Host "###        Backing Up Videos to NAS        ###" -ForegroundColor Blue
$src_Path = 'C:\Users\gavar\Videos'
if(!(Test-Path -Path $src_Path )){
    New-Item -ItemType directory -Path $src_Path
    Write-Host "Video folder created to be used as source :-(" -ForegroundColor Red
}
else
{
    Write-Host "Using Existing Video folder as source :-)" -ForegroundColor Green
}
$dest_Path = 'h:\Videos\'

Get-ChildItem $src_Path -Recurse | % {
    Write-Host "Uploading Videos to NAS: " $_.FullName
    Copy-Item $_.FullName -Destination $dest_Path -Recurse -force -ErrorAction Continue #SilentlyContinue
}

Write-Host "###     File upload to NAS Completed        ###" -ForegroundColor Green