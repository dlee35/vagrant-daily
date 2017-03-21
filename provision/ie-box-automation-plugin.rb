# -*- mode: ruby -*-
# vi: set ft=ruby :

##
# If you copy this file, dont't delete this comment.
# This Vagrantfile was created by Daniel Menezes:
#   https://github.com/danielmenezesbr/modernie-winrm
#   E-mail: danielmenezes at gmail dot com
##

require 'rubygems'
require 'net/ssh'

# TODO
# ====
#   Uses config.ssh in Net::SSH.start
#   test in win8/10
#   add activate (view desktop information)
#   use logger for debug


# Function to check whether VM was already provisioned
def provisioned?(vm_name='default', provider='virtualbox')
  File.exist?(".vagrant/machines/#{vm_name}/#{provider}/action_provision")
end

module LocalCommand

    class Config < Vagrant.plugin("2", :config)
        #attr_accessor :command
    end

    class MyPlugin < Vagrant.plugin("2")
        name "ie_box_automation"

        config(:ie_box_automation, :provisioner) do
            Config
        end

        provisioner(:ie_box_automation) do
            Provisioner
        end
    end

    class Provisioner < Vagrant.plugin("2", :provisioner)
        def provision
            #result = system "#{config.command}"
            begin
                ssh = Net::SSH.start("localhost", "IEUser", :password => "Passw0rd!", :port => 2222)

                #puts "Disabling firewall..."
                #res = ssh.exec!('NetSh Advfirewall set allprofiles state off')
                #for debug
                #puts res

                #puts "Waiting for network..."
                #res = ssh.exec!('ping -n 10 8.8.8.8')
                #for debug
                #puts res

                puts "Changing network location..."
                res = ssh.exec!('powershell -c "get-netconnectionprofile | set-netconnectionprofile -networkcategory private"')
		res = ssh.exec!('winrm.cmd quickconfig -q -transport:http')
		res = ssh.exec!("winrm.cmd set winrm/config/client '@{AllowUnencrypted=\"true\"}'")
		res = ssh.exec!("winrm.cmd set winrm/config/service '@{AllowUnencrypted=\"true\"}'")
		res = ssh.exec!("winrm.cmd set winrm/config/service/auth '@{Basic=\"true\"}'")
		res = ssh.exec!('net stop winrm')
		res = ssh.exec!('sc.exe config winrm start=auto')
		res = ssh.exec!('net start winrm')
                #for debug
                #puts res
                
                #puts "Turn off User Account Control..."
                #res = ssh.exec!("cmd /c \"reg add HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System /v EnableLUA /d 0 /t REG_DWORD /f /reg:64\"")

                #puts "Creating link to config WinRM on Startup..."
                #res = ssh.exec!("mv ./tools/ConfigWinRM.lnk \"/cygdrive/c/Users/IEUser/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup\"")
                #for debug
                #puts res

                puts 'Shutting down guest machine...'
                ssh.exec!("shutdown -t 0 -s -f")
                
                $done = false;
                while !$done do
                    begin
                        result = Vagrant::Util::Subprocess.execute(
                            'vagrant',
                            'status',
                            :notify => [:stdout, :stderr],
                            #:workdir => config.cwd,
                            :env => {PATH: ENV["VAGRANT_OLD_ENV_PATH"]},
                        ) do |io_name, data|
                            #@machine.env.ui.debug "[#{io_name}] #{data}"
                            if data.include? "The VM is running"
                                puts 'The VM is running... Waiting shutdown...'
                                sleep(30)
                            else
                                $done = true
                                puts 'The VM is not running. Next command should be vagrant up...'
                            end
                        end
                    rescue Exception => e
                        $done = true
                        puts 'Exception...'
                    end
                end
                ssh.close
            rescue Exception => e
                puts "uncaught #{e} exception while handling connection: #{e.message}"
            end
        end
    end
end
