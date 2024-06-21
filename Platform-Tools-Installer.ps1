if ($Host.Version.Major -lt 5) {
	Write-Host -Object 'PowerShell 5 oder höher!!!' -ForegroundColor 'Red'
	Start-Sleep -Seconds 2
	Exit
}

$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Add-Type -AssemblyName 'System.Windows.Forms'
$folderDialog = New-Object -TypeName 'System.Windows.Forms.FolderBrowserDialog'

Write-Verbose -Message 'Lade Platform Tools runter...' -Verbose
$Parameters = @{
	Uri             = 'https://dl.google.com/android/repository/platform-tools-latest-windows.zip'
	OutFile         = "$env:Temp\platform-tools.zip"
	UseBasicParsing = $true
}
Invoke-WebRequest @Parameters

Write-Host
Write-Host -Object 'Ordner für die Installation wählen..'

if ($folderDialog.ShowDialog() -eq 'OK') {
	Write-Host
	Write-Verbose -Message 'Platform Tools werden ausgepackt...' -Verbose
	$Parameters = @{
		Path        = "$env:Temp\platform-tools.zip"
		Destination = $folderDialog.SelectedPath
		Force       = $true
	}
	Expand-Archive @Parameters
	
	$platformToolsPath = "$($folderDialog.SelectedPath)\platform-tools"
	if ($env:Path -notlike "*$platformToolsPath*") {
		[Environment]::SetEnvironmentVariable('Path', "$env:Path`;$platformToolsPath", 'User')
	}
	
	Remove-Item -Path $Parameters.Path -Force
	
	Write-Host
	Write-Host -Object 'Platform Tools wurden ohne Fehler installiert!' -ForegroundColor 'Green'
	Start-Sleep -Seconds 2
}
else {
	Write-Host
	Write-Host -Object 'Ordner nicht gewählt!!' -ForegroundColor 'Red'
	Start-Sleep -Seconds 2
}
