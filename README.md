### This repo will create a working Win10 image that allows one to connect to *necessary* resources.

#### It uses the Windows 10 vagrant image from M$. The machine is licensed for 90 days, but a simple **vagrant destroy** and reprovision using the *compound vagrant command below* will rectify. It is assumed there isn't a valid need to store data locally and all required storage will take place through a synced folder. Please configure your smartcard reader via the Vagrantfile if you would like to automount the device. 

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
  * Win10 image from Modern.IE: http://aka.ms/msedge.win10.vagrant
    * Extracted with the Vagrantfile pointing to the proper box file
  * Vagrant
  * VirtualBox or VMWare w/Vagrant plugin <= adjust the provisioner accordingly
  * Vagrant-Triggers <= vagrant plugin install vagrant-triggers
  * InstallRoot from MilitaryCAC or another trusted source

###### Credit goes to https://github.com/danielmenezesbr/modernie-winrm for the sweet provisioning plugin
###### I'll add the other link I used when I find it...
