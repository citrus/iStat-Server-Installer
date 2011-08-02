iStat-Server-Installer
======================

Just a simple shell script that automates the installation of iStat Server on Ubuntu systems. 


#### First, make sure you have libxml2-dev installed!! It's required by iStatServer.


To install:

    cd ~/sources # or your preferred source directory
    
    git clone git://github.com/citrus/iStat-Server-Installer.git
    
    cd iStat-Server-Installer/


Now edit `istat.conf` to your liking, then run:

    sudo sh ./istatserver.sh install


### To add the init.d script:

    cd ~/sources/iStat-Server-Installer # or wherever you cloned to
    
    sudo cp etc/istatserver /etc/init.d/istatserver
    sudo chmod +x /etc/init.d/istatserver
    sudo update-rc.d istatserver defaults


You'll have to add a rule to your iptables too to allow the connection...
