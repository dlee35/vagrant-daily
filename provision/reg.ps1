Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "bginfo"

Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name WallPaper -Value "c:\windows\web\wallpaper\theme1\img13.jpg"
