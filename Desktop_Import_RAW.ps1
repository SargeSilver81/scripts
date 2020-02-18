param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("online","offline","upload","olivia","NAS","video")]
    [string]$a
    )
# FOR OLIVIA
    if ($a -eq 'olivia' ) {  
        $sourcePath = 'E:\DCIM\*D3200\'
        $destPath = 'G:\OneDrive\My Pictures\Nikon_D3200\Olivia'

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
        $destPath = 'G:\OneDrive\My Pictures\Nikon_Z6\Z 6 7402118\DCIM\100NCZ_6'

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

        Get-ChildItem $sourcePath -Recurse -include ('*.NEF','*.JPG') -Name | Out-File -FilePath 'G:\OneDrive\My Pictures\Nikon_Z6\Z 6 7402118\ToUploadToNAS.txt' -Append

        Get-ChildItem $sourcePath -Recurse -include ('*.NEF','*.JPG') | ForEach-Object {
            ++$lc
            Write-Host "Moving ($lc/$Total): " $_.FullName
            Move-Item -Path $_.FullName -Destination $destPath -Force
        }
    }
    if ($a -eq 'online' -OR $a -eq 'NAS' ) {

        Write-Host "# Adding temp drive location" -ForegroundColor Gray

        $net = new-object -ComObject WScript.Network
        $net.MapNetworkDrive("n:", "\\SILVERNAS\Photo\RAW_Import", $false) 
        if ($LASTEXITCODE -eq 0){
            write-host "# N: Mapped Successfully!" -ForegroundColor Green
        } else {
            Write-Error "N: NOT MAPPED - FAILING!" -ErrorAction Stop
            $noDrive = "1"
        }

        if($noDrive -eq $null){
            $temp_path = 'G:\OneDrive\My Pictures\Nikon_Z6\Z 6 7402118\DCIM\100NCZ_6'
            if(!(Test-Path -Path $temp_path )){
                New-Item -ItemType directory -Path $temp_path
                Write-Host "New folder created"
            }
            else
            {
            Write-Host "Folder already exists"
            }
            $destPathNAS = 'n:\'

            # Use NAS file for list of files to upload
            $file_list = Get-Content -Path 'G:\OneDrive\My Pictures\Nikon_Z6\Z 6 7402118\ToUploadToNAS.txt'

            foreach ($file in $file_list) {
                Write-Host "Uploading: "$temp_path\$file" to: NAS"
                Copy-Item $temp_path\$file $destPathNAS -ErrorAction Continue

            }

            Write-Host "Removing temp drive location" -ForegroundColor Red
            net use N: /delete
            Write-Host "Removing NAS Processing List" -ForegroundColor Red
            Remove-Item -Path 'G:\OneDrive\My Pictures\Nikon_Z6\Z 6 7402118\ToUploadToNAS.txt' -Force
        }
    }
    if ($a -eq 'video' ) {
        $sourcePath = 'F:\DCIM\*NCZ_6\'
        $destPath = 'G:\OneDrive\Videos\Z6_Videos'
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

        Get-ChildItem $sourcePath -Recurse -filter *.MP4 -Name | Out-File -FilePath 'G:\OneDrive\Videos\Z6_Videos\ToUploadToNAS.txt' -Append

        Get-ChildItem $sourcePath -Recurse -filter *.MP4 | ForEach-Object {
            ++$lc
            Write-Host "Moving ($lc/$Total): " $_.FullName
            Move-Item -Path $_.FullName -Destination $destPath -Force
        }

        Write-Host "# Adding temp drive location" -ForegroundColor Gray
    
        $net = new-object -ComObject WScript.Network
        $net.MapNetworkDrive("n:", "\\SILVERNAS\Video\Z6_Videos", $false) 
            if ($LASTEXITCODE -eq 0){
                write-host "# N: Mapped Successfully!" -ForegroundColor Green
            } else {
                Write-Error "N: NOT MAPPED - FAILING!" -ErrorAction Stop
                $noDrive = "1"
            }
    
            if($noDrive -eq $null){
                $temp_path = 'G:\OneDrive\Videos\Z6_Videos'
                if(!(Test-Path -Path $temp_path )){
                    New-Item -ItemType directory -Path $temp_path
                    Write-Host "New folder created"
                } else {
                    Write-Host "Folder already exists"
                }
                $destPathNAS = 'n:\'
    
                # Use NAS file for list of files to upload
                $file_list = Get-Content -Path 'G:\OneDrive\Videos\Z6_Videos\ToUploadToNAS.txt'
    
                foreach ($file in $file_list) {
                Write-Host "Uploading: "$temp_path\$file" to: NAS"
                Copy-Item $temp_path\$file $destPathNAS -ErrorAction Continue
    
                }

                Write-Host "Removing temp drive location" -ForegroundColor Red
                net use N: /delete
                Write-Host "Removing NAS Processing List" -ForegroundColor Red
                Remove-Item -Path 'G:\OneDrive\Videos\Z6_Videos\ToUploadToNAS.txt' -Force
            }
    }