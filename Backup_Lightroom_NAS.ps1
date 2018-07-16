 Write-Host "Backing Up Lightroom to NAS" -ForegroundColor Blue
 
 #Write-Host "Adding temp drive location" -ForegroundColor Green

        #$net = new-object -ComObject WScript.Network
        #$net.MapNetworkDrive("l:", "\\d.docs.live.net\FB814EDDAABC830D\Lightroom", $false, "gavargent@gmail.com", "OliviaJayn3")

        $temp_path = 'C:\Users\gavar\Pictures\Lightroom'
        if(!(Test-Path -Path $temp_path )){
            New-Item -ItemType directory -Path $temp_path
            Write-Host "Lightroom folder created :-(" -ForegroundColor Red
        }
        else
        {
          Write-Host "Lightroom folder exists :-)" -ForegroundColor Green
        }
        $destPath2 = 'h:\Photos\Lightroom\'

        Get-ChildItem $temp_path -Recurse | % {
            Write-Host "Uploading to NAS: " $_.FullName
            #Copy-Item  -Path $copyAdmin -Destination $AdminPath -Recurse -force
            Copy-Item $_.FullName -Destination $destPath2 -Recurse -force -ErrorAction Continue #SilentlyContinue
        }

        #Write-Host "Removing temp drive location" -ForegroundColor Red
        #Remove-PSDrive RAW_Backup
        #net use L: /delete
        #Get-PSDrive -PSProvider FileSystem
