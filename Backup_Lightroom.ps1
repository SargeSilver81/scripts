function Copy-File {
    param( [string]$from, [string]$to)
    $ffile = [io.file]::OpenRead($from)
    $tofile = [io.file]::OpenWrite($to)
    Write-Progress -Activity "Copying file" -status "$from -> $to" -PercentComplete 0
    try {
        [byte[]]$buff = new-object byte[] 4096
        [int]$total = [int]$count = 0
        do {
            $count = $ffile.Read($buff, 0, $buff.Length)
            $tofile.Write($buff, 0, $count)
            $total += $count
            if ($total % 1mb -eq 0) {
                Write-Progress -Activity "Copying file" -status "$from -> $to" `
                   -PercentComplete ([int]($total/$ffile.Length* 100))
            }
        } while ($count -gt 0)
    }
    finally {
        $ffile.Dispose()
        $tofile.Dispose()
        Write-Progress -Activity "Copying file" -Status "Ready" -Completed
    }
}

 Write-Host "Backing Up Lightroom to NAS" -ForegroundColor Blue
 
 #Write-Host "Adding temp drive location" -ForegroundColor Green

#        $net = new-object -ComObject WScript.Network
#        $net.MapNetworkDrive("l:", "\\d.docs.live.net\FB814EDDAABC830D\Lightroom", $false, "gavargent@gmail.com", "OliviaJayn3")

        $temp_path = 'C:\Users\gavar\Pictures\Lightroom'
        if(!(Test-Path -Path $temp_path )){
            New-Item -ItemType directory -Path $temp_path
            Write-Host "New folder created :-(" -ForegroundColor Red
        }
        else
        {
          Write-Host "Folder already exists :-)" -ForegroundColor Green
        }
        $destPath2 = 'h:\Photos\'

        Get-ChildItem $temp_path -Recurse | % {
            #Write-Host "Uploading to OneDrive: " $_.FullName
            #Copy-Item  -Path $copyAdmin -Destination $AdminPath -Recurse -force
            #Copy-Item $_.FullName -Destination $destPath2 -force -ErrorAction Continue #SilentlyContinue
            Copy-File $_.FullName $destPath2
        }

#        Write-Host "Removing temp drive location" -ForegroundColor Red
        
#        net use L: /delete
