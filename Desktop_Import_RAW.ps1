param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("online","offline","upload","olivia","NAS","video","forestcam")]
    [string]$a
    )
# FOR OLIVIA
    if ($a -eq 'olivia' ) {  
        $sourcePath = 'E:\DCIM\*D3200\'
        $destPath = 'O:\OneDrive\My Pictures\Nikon_D3200\Olivia'

        if(!(Test-Path -Path $destPath )){
            New-Item -ItemType directory -Path $destPath
            Write-Host "Olivia folder created"
        }

        Write-Host "## RAW Camera Import##" -ForegroundColor Yellow
        $Total = ( Get-ChildItem $sourcePath -Recurse -filter DSC*.NEF | Measure-Object ).Count;
        $lc = 0

        if($Total -eq 0) {
            Write-Host "No RAW Files Found!" -ForegroundColor Red
        }

        Get-ChildItem $sourcePath -Recurse -filter DSC*.NEF | ForEach-Object {
            ++$lc
            Write-Host "Copying ($lc/$Total): " $_.FullName
            Copy-Item $_.FullName -Destination $destPath -ErrorAction SilentlyContinue
        }
    }
# FOR GAV
    if ($a -eq 'online' -OR $a -eq 'offline' ) {  
        $sourcePath = 'F:\DCIM\*NCZ_6\'
        $destPath = 'O:\OneDrive\My Pictures\Nikon_Z6\Z 6 7402118\DCIM\100NCZ_6'

        if(!(Test-Path -Path $destPath )){
            New-Item -ItemType directory -Path $destPath
            Write-Host "Nikon_Z6 folder/path created"
        }

        Write-Host "#############- Photo Import -#############"  -ForegroundColor DarkBlue -BackgroundColor Yellow

        if (-not (Test-Path -Path $sourcePath)) {
            throw 'Memory Card NOT Inserted!'
        } else {
            write-host '# Memory Card Inserted - Getting Photos' -ForegroundColor Green
        }

        $Total = ( Get-ChildItem $sourcePath -Recurse -filter *.NEF | Measure-Object ).Count;

        $lc = 0

        Get-ChildItem $sourcePath -Recurse -include ('*.NEF','*.JPG') -Name | Out-File -FilePath 'O:\OneDrive\My Pictures\Nikon_Z6\Z 6 7402118\ToUploadToNAS.txt' -Append

        Get-ChildItem $sourcePath -Recurse -include ('*.NEF','*.JPG') | ForEach-Object {
            ++$lc
            Write-Host "Moving ($lc/$Total): " $_.FullName
            Move-Item -Path $_.FullName -Destination $destPath -Force
        }
    }
    if ($a -eq 'video' ) {
        $sourcePath = 'F:\DCIM\*NCZ_6\'
        $destPath = 'O:\OneDrive\Videos\Z6_Videos'
        if(!(Test-Path -Path $destPath )){
            New-Item -ItemType directory -Path $destPath
            Write-Host "Z6_Videos folder/path created"
        }

        Write-Host "#############- Video Import -#############" -ForegroundColor DarkBlue -BackgroundColor Yellow

        if (-not (Test-Path -Path $sourcePath)) {
            throw 'Memory Card NOT Inserted!'
        } else {
            write-host '# Memory Card Inserted - Getting Videos' -ForegroundColor Green
        }

        $Total = ( Get-ChildItem $sourcePath -Recurse -filter *.MP4 | Measure-Object ).Count;

        $lc = 0

        Get-ChildItem $sourcePath -Recurse -filter *.MP4 -Name | Out-File -FilePath 'O:\OneDrive\Videos\Z6_Videos\ToUploadToNAS.txt' -Append

        Get-ChildItem $sourcePath -Recurse -filter *.MP4 | ForEach-Object {
            ++$lc
            Write-Host "Moving ($lc/$Total): " $_.FullName
            Move-Item -Path $_.FullName -Destination $destPath -Force
        }
    }
    if ($a -eq 'forestcam' ) {
        $sourcePath = 'E:\DCIM\'
        $destPath = 'O:\OneDrive\Videos\Forest-Cam\Import'
        if(!(Test-Path -Path $destPath )){
            New-Item -ItemType directory -Path $destPath
            Write-Host "Forest-Cam folder/path created"
        }

        Write-Host "#############- Forest Cam Import -#############" -ForegroundColor DarkBlue -BackgroundColor Yellow

        if (-not (Test-Path -Path $sourcePath)) {
            throw 'Memory Card NOT Inserted!'
        } else {
            write-host '# Memory Card Inserted - Getting Videos' -ForegroundColor Green
        }

        $Total = ( Get-ChildItem $sourcePath -Recurse -filter *.AVI | Measure-Object ).Count;

        $lc = 0

        Get-ChildItem $sourcePath -Recurse -filter *.AVI -Name | Out-File -FilePath 'O:\OneDrive\Videos\Forest-Cam\Import\ToUploadToNAS.txt' -Append

        Get-ChildItem $sourcePath -Recurse -filter *.AVI | ForEach-Object {
            ++$lc
            Write-Host "Moving ($lc/$Total): " $_.FullName
            Move-Item -Path $_.FullName -Destination $destPath -Force
        }
    }