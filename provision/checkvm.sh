#!/bin/bash
if vagrant box list | grep dev-msedge; then
    exit 0
else
    if [ ! -f dev-msedge.box ]; then
        if [ -f MSEdge.Win10_RS1.Vagrant.zip ]; then
            7z e MSEdge.Win10_RS1.Vagrant.zip -so > dev-msedge.box && \
            vagrant box add dev-msedge.box --name dev-msedge
        else
            wget https://az792536.vo.msecnd.net/vms/VMBuild_20160810/Vagrant/MSEdge/MSEdge.Win10_RS1.Vagrant.zip && \
            7z e MSEdge.Win10_RS1.Vagrant.zip -so > dev-msedge.box && \
            vagrant box add dev-msedge.box --name dev-msedge
        fi
    fi
fi
