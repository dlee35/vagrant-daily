#!/bin/sh
#Get-NetConnectionProfile | Set-NetConnectionProfile -NetworkCategory Private

powershell -c set-netconnectionprofile -networkcategory private
winrm quickconfig -q -transport:http
winrm set winrm/config/client '@{AllowUnencrypted="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
net stop winrm
sc.exe config winrm start=auto
net start winrm
