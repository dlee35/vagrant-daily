### This repo will create a working Win10 image that allows one to connect to *necessary* resources.

* Performs the following:
  * winrm management
  * chocolatey package installs:
    * adobe reader
    * notepad++
    * python2
    * java
  * package required from militarycac:
    * InstallRoot*version*.msi

**Run:**
**vagrant up && vagrant up --provision-with certs,programs,registry,install && vagrant reload**

* Requires the following
  * Win10 image from Modern.IE: http://aka.ms/ie11.win10.vagrant
    * Extracted with the Vagrantfile pointing to the proper box file
  * Vagrant
  * VirtualBox or VMWare w/Vagrant plugin
  * InstallRoot from MilitaryCAC or another trusted source

###### Credit goes to https://github.com/danielmenezesbr/modernie-winrm for the sweet provisioning plugin
###### I'll add the other link I used when I find it...
