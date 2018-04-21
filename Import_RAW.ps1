param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("online","offline","upload")]
    [string]$a
    )

    if ($a -eq 'online' -OR $a -eq 'offline' ) {  
        $sourcePath = 'F:\DCIM\100D3200\'
        $destPath = 'C:\Users\gavar\Pictures\Lightroom\Gav_Argent\For_Import'

        Write-Host "## Lightroom Import##" -ForegroundColor Yellow

        Get-ChildItem $sourcePath -Recurse -filter _DSC*.NEF | % {
            Write-Host "Copying: " $_.FullName
            Copy-Item $_.FullName -Destination $destPath -ErrorAction SilentlyContinue
        }

        Get-ChildItem $sourcePath -Recurse -filter *.NEF -exclude _DSC* | % {
            Write-Host "Copying: " $_.FullName
            Copy-Item $_.FullName -Destination $destPath -ErrorAction SilentlyContinue
        }

        Write-Host "## OneDrive Backup ##" -ForegroundColor Blue

        # Originals to OneDrive
        #"https://d.docs.live.net/FB814EDDAABC830D"

        $temp_path = 'c:\RAWBackupTemp'

        if(!(Test-Path -Path $temp_path )){
            New-Item -ItemType directory -Path $temp_path
            Write-Host "New folder created"
        }
        else
        {
          Write-Host "Folder already exists"
        }

        Get-ChildItem $sourcePath -Recurse -filter *.NEF | % {
            Write-Host "Moving to RAWBackupTemp: " $_.FullName
            Move-Item $_.FullName -Destination $temp_path -ErrorAction SilentlyContinue
        }

    }
    if ($a -eq 'online' -OR $a -eq 'upload' ) {

        Write-Host "Adding temp drive location" -ForegroundColor Green

        $net = new-object -ComObject WScript.Network
        $net.MapNetworkDrive("r:", "\\d.docs.live.net\FB814EDDAABC830D\RAW_Backup", $false, "gavargent@gmail.com", "OliviaJayn3")

        $temp_path = 'c:\RAWBackupTemp'
        if(!(Test-Path -Path $temp_path )){
            New-Item -ItemType directory -Path $temp_path
            Write-Host "New folder created"
        }
        else
        {
          Write-Host "Folder already exists"
        }
        $destPath2 = 'r:\'

        Get-ChildItem $temp_path -Recurse -filter *.NEF | % {
            Write-Host "Uploading to OneDrive: " $_.FullName
            Move-Item $_.FullName -Destination $destPath2 -ErrorAction Continue #SilentlyContinue
        }

        Write-Host "Removing temp drive location" -ForegroundColor Red
        #Remove-PSDrive RAW_Backup
        net use R: /delete
        #Get-PSDrive -PSProvider FileSystem
    }