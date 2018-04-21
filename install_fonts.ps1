$FONTS = 0x14;

$FromPath = "C:\Users\gavar\OneDrive\Fonts";

$ObjShell = New-Object -ComObject Shell.Application;
$ObjFolder = $ObjShell.Namespace($FONTS);

$CopyOptions = 4 + 16;
$CopyFlag = [String]::Format("{0:x}", $CopyOptions);

foreach($File in $(Get-ChildItem -Path $FromPath -Recurse -filter *.ttf)){
    If (Test-Path "c:\Windows\Fonts\$($File.name)")
    { }
    Else
    {
        $CopyFlag = [String]::Format("{0:x}", $CopyOptions);
        $ObjFolder.CopyHere($File.fullname, $CopyOptions);

        New-ItemProperty -Name $File.fullname -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -PropertyType string -Value $File 
    }
}