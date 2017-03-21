iex ((New-Object Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) 

# For some reason, AutoHotkey.portable wasn't working with WinPcap, so use the full installation
#cinst sysinternals 7zip wireshark processhacker googlechrome jre8 python2 notepadplusplus adobereader vmwarevsphereclient autohotkey -y
cmd.exe /c "cinst C:\Users\IEUser\packages.config -y"
#$env:Path = "$($env:Path)C:\Program Files\AutoHotkey;" 
cmd.exe /c "msiexec.exe /i C:\Users\IEUser\InstallRoot.msi" /qn
cmd.exe /c "timeout 10"
cmd.exe /c "C:\Users\IEUser\AppData\Roaming\DoD-PKE\InstallRoot\InstallRoot.exe --silent"
#cmd.exe /c "C:\Users\IEUser\Downloads\OfficeSetupx64.exe"
