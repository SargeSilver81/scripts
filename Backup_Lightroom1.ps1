 Write-Host "Backing Up Lightroom to OneDrive" -ForegroundColor Blue
 
 Write-Host "Adding temp drive location" -ForegroundColor Green

        $net = new-object -ComObject WScript.Network
        $net.MapNetworkDrive("l:", "\\d.docs.live.net\FB814EDDAABC830D\Lightroom", $false, "gavargent@gmail.com", "OliviaJayn3")

        $temp_path = 'C:\Users\gavar\Pictures\Lightroom'
        if(!(Test-Path -Path $temp_path )){
            New-Item -ItemType directory -Path $temp_path
            Write-Host "New folder created :-(" -ForegroundColor Red
        }
        else
        {
          Write-Host "Folder already exists :-)" -ForegroundColor Green
        }
        $destPath2 = 'l:\'

        Get-ChildItem $temp_path -Recurse | % {
            Write-Host "Uploading to OneDrive: " $_.FullName
            #Copy-Item  -Path $copyAdmin -Destination $AdminPath -Recurse -force
            Copy-Item $_.FullName -Destination $destPath2 -force -ErrorAction Continue #SilentlyContinue
        }

        Write-Host "Removing temp drive location" -ForegroundColor Red
        #Remove-PSDrive RAW_Backup
        net use L: /delete
        #Get-PSDrive -PSProvider FileSystem
