$sourcePath = 'C:\Users\gavar\Pictures\Processed'
$destPath = 'P:\Processed'

Write-Host "## Sync Processed to SILVERNAS ##" -ForegroundColor Yellow
$Total = ( Get-ChildItem $sourcePath -Recurse | Measure-Object ).Count;
$lc = 0

Get-ChildItem $sourcePath -filter "*" -recurse | `
    foreach{ 
        ++$lc
        Write-Host "Copying ($lc/$Total): " $_.FullName
        $File  = $_.FullName.SubString($sourcePath.Length); 
        $targetFile = $destPath + $_.FullName.SubString($sourcePath.Length);
        
        $a = Test_Path -Path $File -PathType Container

        Write-Host $File " - " $a
        if ($a = "True") {
            $targetDir = $destPath + $_.FullName.SubString($sourcePath.Length);
            New-Item -ItemType Directory -Force -Path $targetDir
        } ELSE {
            $targetFile = $destPath + $_.FullName.SubString($sourcePath.Length); 
            Copy-Item $_.FullName -destination $targetFile -Recurse -Container -ErrorAction Continue
        }
    } 