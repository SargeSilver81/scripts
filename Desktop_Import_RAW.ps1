param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("online","offline","upload","olivia","NAS")]
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

        Write-Host "## RAW Import##" -ForegroundColor Yellow
        $Total = ( Get-ChildItem $sourcePath -Recurse -filter _DSC*.NEF | Measure-Object ).Count;
        $lc = 0

        Get-ChildItem $sourcePath -Recurse -filter _DSC*.NEF | ForEach-Object {
            ++$lc
            Write-Host "Copying ($lc/$Total): " $_.FullName
            Move-Item $_.FullName -Destination $destPath -ErrorAction SilentlyContinue
        }

        $Total = ( Get-ChildItem $sourcePath -Recurse -filter *.NEF -exclude _DSC* | Measure-Object ).Count;
        $lc = 0
        Get-ChildItem $sourcePath -Recurse -filter *.NEF -exclude _DSC* | ForEach-Object {
            ++$lc
            Write-Host "Copying ($lc/$Total): " $_.FullName
            Move-Item $_.FullName -Destination $destPath -ErrorAction SilentlyContinue
        }
    }
    if ($a -eq 'online' -OR $a -eq 'NAS' ) {

        Write-Host "Adding temp drive location" -ForegroundColor Green

        $net = new-object -ComObject WScript.Network
        $net.MapNetworkDrive("n:", "\\SILVERNAS\Photo\RAW_Import", $false)


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

        Write-Host "Files to upload: "( Get-ChildItem $temp_path -Recurse -filter *.NEF | Measure-Object ).Count;
        $Total = ( Get-ChildItem $temp_path -Recurse -filter *.NEF | Measure-Object ).Count;
        $lc = 0

        Get-ChildItem $temp_path -Recurse -filter *.NEF | ForEach-Object {
            ++$lc
            Write-Host "Uploading to NAS ($lc/$Total): " $_.FullName
            Copy-Item $_.FullName -Destination $destPathNAS -ErrorAction Continue #SilentlyContinue
        }

        Write-Host "Removing temp drive location" -ForegroundColor Red
        net use N: /delete
    }