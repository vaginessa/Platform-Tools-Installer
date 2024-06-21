# Platform Tools Installer

![pti](https://user-images.githubusercontent.com/115353812/221406600-16fb339b-d5de-4359-808e-7c8d31876c2a.png)

## How to (Windows)

Run PowerShell as Administrator, paste these commands and then press Enter.

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
iwr 'https://raw.githubusercontent.com/vaginessa/Platform-Tools-Installer/main/Platform-Tools-Installer.ps1' -useb | iex
```


## Requirements (Linux)

- Bash
- Unzip package
