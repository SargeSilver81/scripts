param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("online","offline","upload")]
    [string]$a
    )
    if ($a -eq 'online' -OR $a -eq 'upload' ) {
        #net use O: /delete
        #net use N: /delete
    Write-Host "Adding temp drive location" -ForegroundColor Green

        $net = new-object -ComObject WScript.Network
        $net.MapNetworkDrive("O:", "\\d.docs.live.net\FB814EDDAABC830D\NAS", $false, "gavargent@gmail.com", "OliviaJayn3")
        Write-Host "Drive O: mapped"
        $Network = New-Object -ComObject "Wscript.Network"
        $Network.MapNetworkDrive("N:", "\\192.168.1.123\nas")
        Write-Host "Drive N: mapped"

        $source = "C:\hold\first test"
        $destination = "C:\hold\second test"
        $robocopyOptions = " /MT:16 /copyall /s  /xf *.NEF"
        $fileList = "test.txt"
        
        $temp_path = 'N:\Videos'
        if(!(Test-Path -Path $temp_path )){
            New-Item -ItemType directory -Path $temp_path
            Write-Host "New folder ($temp_path) created"
        }
        else
        {
          Write-Host "Folder ($temp_path) already exists"
        }
        $destPath2 = 'O:\Videos'
        if(!(Test-Path -Path $destPath2 )){
            New-Item -ItemType directory -Path $destPath2
            Write-Host "New folder ($destPath2) created"
        }
        else
        {
          Write-Host "Folder ($destPath2) already exists"
        }

        #Write-Host "Files to upload: "( Get-ChildItem $temp_path -Recurse | Measure-Object ).Count;
        Start robocopy -args "$temp_path $destPath2 $fileLIst $robocopyOptions"
        #Write-Host "Counting files in $temp_path"
        #$Total = ( Get-ChildItem $temp_path -Recurse | Measure-Object ).Count;
        #$lc = 0

        #Get-ChildItem $temp_path -Recurse | % {
        #    ++$lc
        #    Write-Host "Uploading to OneDrive ($lc/$Total): " $_.FullName
        #    Copy-Item $_.FullName -Destination $destPath2 -ErrorAction Continue  #SilentlyContinue
        #}

        $temp_path = 'N:\Photos'
        if(!(Test-Path -Path $temp_path )){
            New-Item -ItemType directory -Path $temp_path
            Write-Host "New folder ($temp_path) created"
        }
        else
        {
          Write-Host "Folder ($temp_path) already exists"
        }
        $destPath2 = 'O:\Photos'
        if(!(Test-Path -Path $destPath2 )){
            New-Item -ItemType directory -Path $destPath2
            Write-Host "New folder ($destPath2) created"
        }
        else
        {
          Write-Host "Folder ($destPath2) already exists"
        }

        #Write-Host "Files to upload: "( Get-ChildItem $temp_path -Recurse | Measure-Object ).Count;
        Start robocopy -args "$temp_path $destPath2 $fileLIst $robocopyOptions"
        #Write-Host "Counting files in $temp_path"
        #$Total = ( Get-ChildItem $temp_path -Recurse | Measure-Object ).Count;
        #$lc = 0

        #Get-ChildItem $temp_path -Recurse | % {
        #    ++$lc
        #    Write-Host "Uploading to OneDrive ($lc/$Total): " $_.FullName
        #    Copy-Item $_.FullName -Destination $destPath2 -ErrorAction Continue  #SilentlyContinue
        #}

        $temp_path = 'N:\Applications'
        if(!(Test-Path -Path $temp_path )){
            New-Item -ItemType directory -Path $temp_path
            Write-Host "New folder created"
        }
        else
        {
          Write-Host "Folder already exists"
        }
        $destPath2 = 'O:\Applications'
        if(!(Test-Path -Path $destPath2 )){
            New-Item -ItemType directory -Path $destPath2
            Write-Host "New folder ($destPath2) created"
        }
        else
        {
          Write-Host "Folder ($destPath2) already exists"
        }

        #Write-Host "Files to upload: "( Get-ChildItem $temp_path -Recurse | Measure-Object ).Count;
        Start robocopy -args "$temp_path $destPath2 $fileLIst $robocopyOptions"
        #Write-Host "Counting files in $temp_path"
        #$Total = ( Get-ChildItem $temp_path -Recurse | Measure-Object ).Count;
        #$lc = 0

        #Get-ChildItem $temp_path -Recurse | % {
        #    ++$lc
        #    Write-Host "Uploading to OneDrive ($lc/$Total): " $_.FullName
        #    Copy-Item $_.FullName -Destination $destPath2 -ErrorAction Continue  #SilentlyContinue
        #}

        $temp_path = 'N:\Aquisitions'
        if(!(Test-Path -Path $temp_path )){
            New-Item -ItemType directory -Path $temp_path
            Write-Host "New folder created"
        }
        else
        {
          Write-Host "Folder already exists"
        }
        $destPath2 = 'O:\Aquisitions'
        if(!(Test-Path -Path $destPath2 )){
            New-Item -ItemType directory -Path $destPath2
            Write-Host "New folder ($destPath2) created"
        }
        else
        {
          Write-Host "Folder ($destPath2) already exists"
        }

        #Write-Host "Files to upload: "( Get-ChildItem $temp_path -Recurse | Measure-Object ).Count;
        Start robocopy -args "$temp_path $destPath2 $fileLIst $robocopyOptions"
        #Write-Host "Counting files in $temp_path"
        #$Total = ( Get-ChildItem $temp_path -Recurse | Measure-Object ).Count;
        #$lc = 0

        #Get-ChildItem $temp_path -Recurse | % {
        #    ++$lc
        #    Write-Host "Uploading to OneDrive ($lc/$Total): " $_.FullName
        #    Copy-Item $_.FullName -Destination $destPath2 -ErrorAction Continue  #SilentlyContinue
        #}
        
        Write-Host "Removing temp drive location" -ForegroundColor Red
        #ReCopy-PSDrive RAW_Backup
        #net use O: /delete
        #net use N: /delete
        #Get-PSDrive -PSProvider FileSystem
    }