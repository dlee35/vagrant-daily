# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative 'provision/ie-box-automation-plugin.rb'

Vagrant.configure(2) do |config|
    config.vm.box = "win10_daily"
    config.vm.box_check_update = false
    config.vm.box_url = "file:///Users/dustinlee/ISOs/dev-msedge.box"
    config.vm.box_download_checksum_type = "sha1"
    config.vm.box_download_checksum = "d671f36eb36b43c8ce932dd52885b17a164d8447"
    #config.vm.host_name = "burner"
    config.vm.boot_timeout = 600
    config.vm.guest = :windows

    # Box settings
    config.vm.provider "virtualbox" do |vb|
	vb.name = "win10_daily"
	vb.gui = true
        vb.memory = "2048"
        vb.cpus = 2
        vb.customize ['modifyvm', :id, '--usb', 'on']
        vb.customize ["modifyvm", :id, "--vram", "64"]
        vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
        vb.customize ['usbfilter', 'add', '0', '--target', :id, '--name', 'SmartCard', '--vendorid', '0x04e6', '--productid', '0xe001']
    end

    # Start provisioning of box via ssh
    config.ssh.username = "IEUser"
    config.ssh.password = "Passw0rd!"
    config.ssh.insert_key = false
    config.vm.provision "winrm", type: "ie_box_automation"

    # Continue setup 'if provisioned'
    config.vm.communicator = :winrm      if provisioned? 
    config.winrm.username = "IEUser"     if provisioned? 
    config.winrm.password = "Passw0rd!"  if provisioned? 
    config.winrm.timeout = 50000         if provisioned?  

    if provisioned?
        # Copy local files to box
        config.vm.provision "certs", type: "file" do |copy|
            copy.source = "~/vagrant/daily/provision/InstallRoot4.1.msi"
            copy.destination = "C:\\Users\\IEUser\\InstallRoot.msi"
        end
        config.vm.provision "office", type: "file" do |copy|
            copy.source = "~/vagrant/daily/provision/OfficeSetupx64.exe"
            copy.destination = "C:\\Users\\IEUser\\OfficeSetupx64.exe"
        end
        config.vm.provision "programs", type: "file" do |copy|
            copy.source = "~/vagrant/daily/provision/packages.config"
            copy.destination = "C:\\Users\\IEUser\\packages.config" 
        end
        # Remove BGInfo background and install required applications via chocolately and locally
        config.vm.provision "registry", type: "shell", path: "provision/reg.ps1" 
        config.vm.provision "install", type: "shell", path: "provision/installtools.ps1"
    end

    # Host files are shared on the Desktop
    config.vm.synced_folder "/Users/dustinlee/WinVMStuff", "/Users/IEUser/Desktop/Sync" if provisioned? 
end
