param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("online","offline","upload")]
    [string]$a
    )

    if ($a -eq 'online' -OR $a -eq 'offline' ) {  
        $sourcePath = 'F:\DCIM\*D3200\'
        #$destPath = 'C:\Users\gavar\Pictures\Lightroom\Gav_Argent\For_Import'
        $destPath = 'C:\Users\gavar\Pictures\RAW_Import'

        Write-Host "## RAW Camera Import##" -ForegroundColor Yellow
        $Total = ( Get-ChildItem $sourcePath -Recurse -filter _DSC*.NEF | Measure-Object ).Count;
        $lc = 0

        Get-ChildItem $sourcePath -Recurse -filter _DSC*.NEF | ForEach-Object {
            ++$lc
            Write-Host "Copying ($lc/$Total): " $_.FullName
            Copy-Item $_.FullName -Destination $destPath -ErrorAction SilentlyContinue
        }

        $Total = ( Get-ChildItem $sourcePath -Recurse -filter *.NEF -exclude _DSC* | Measure-Object ).Count;
        $lc = 0
        Get-ChildItem $sourcePath -Recurse -filter *.NEF -exclude _DSC* | ForEach-Object {
            ++$lc
            Write-Host "Copying ($lc/$Total): " $_.FullName
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

        $Total = ( Get-ChildItem $sourcePath -Recurse -filter *.NEF | Measure-Object ).Count;
        $lc = 0

        Get-ChildItem $sourcePath -Recurse -filter *.NEF | ForEach-Object {
            ++$lc
            Write-Host "Moving to RAWBackupTemp ($lc/$Total): " $_.FullName
            Move-Item $_.FullName -Destination $temp_path -ErrorAction SilentlyContinue
        }

    }
    if ($a -eq 'online' -OR $a -eq 'upload' ) {

        Write-Host "Adding temp drive location" -ForegroundColor Green

        $net = new-object -ComObject WScript.Network
        $net.MapNetworkDrive("r:", "\\d.docs.live.net\FB814EDDAABC830D\RAW_Backup", $false, "gavargent@gmail.com", "OliviaJayn3")

        $net = new-object -ComObject WScript.Network
        $net.MapNetworkDrive("n:", "\\SILVERNAS\Photo\RAW_Import", $false)


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
        $destPathNAS = 'n:\'

        Write-Host "Files to upload: "( Get-ChildItem $temp_path -Recurse -filter *.NEF | Measure-Object ).Count;
        $Total = ( Get-ChildItem $temp_path -Recurse -filter *.NEF | Measure-Object ).Count;
        $lc = 0

        Get-ChildItem $temp_path -Recurse -filter *.NEF | ForEach-Object {
            ++$lc
            Write-Host "Uploading to NAS ($lc/$Total): " $_.FullName
            Copy-Item $_.FullName -Destination $destPathNAS -ErrorAction Continue #SilentlyContinue
            Write-Host "Uploading to OneDrive ($lc/$Total): " $_.FullName
            Move-Item $_.FullName -Destination $destPath2 -ErrorAction Continue #SilentlyContinue
        }

        Write-Host "Removing temp drive location" -ForegroundColor Red
        #Remove-PSDrive RAW_Backup
        net use R: /delete
        net use N: /delete
        #Get-PSDrive -PSProvider FileSystem
    }