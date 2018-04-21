#Get-ChildItem P:\ -Recurse -Filter _DSC*.NEF

#Copy-Item -Path "P:\*" -filter _DSC*.NEF -Destination "C:\Users\gavar\Downloads\RAW2LightRoom" -Recurse

#Get-Childitem P:\ -Recurse -Filter _DSC*.NEF | % { Copy-Item -Path $_.Path -Destination 'C:\Users\gavar\Downloads\RAW2LightRoom' }



$sourcePath = 'P:\'
$destPath = 'C:\Users\gavar\Downloads\RAW2LightRoom'
#$Files = Get-ChildItem $sourcePath -Recurse -filter _DSC*.NEF | Select-Object Name

Get-ChildItem $sourcePath -Recurse -filter _DSC*.NEF | % {
    Write-Host "Copying: " $_.FullName
    Copy-Item $_.FullName -Destination $destPath -ErrorAction SilentlyContinue
}

Get-ChildItem $sourcePath -Recurse -filter *.NEF -exclude _DSC* | % {
    Write-Host "Copying: " $_.FullName
    Copy-Item $_.FullName -Destination $destPath -ErrorAction SilentlyContinue
}