#!/bin/sh

class_name="iStatInstaller"
version="0.0.2"
istat_version="0.5.6"

url="http://github.com/downloads/tiwilliam/istatd/istatd-$istat_version.tar.gz"

help()
{

  cat <<HELP
------------------------------------
iStat Installer!
------------------------------------

INSTALLATION:
  sh ./istatserver.sh install [istat_version]

TASKS
  [install] install
  [-h] help
  [-v] version
  
VERSION:
  $class_name $version

HELP
  exit 0
}



install()
{ 

  install_dir=$PWD
     
  clear

  
  echo "--------------------------------------"
  echo " STARTING INSTALLATION!"  
  
    url="http://github.com/downloads/tiwilliam/istatd/istatd-$istat_version.tar.gz"
    pkg=istatd-$istat_version
    tgz=$pkg.tar.gz
    cfg=/etc/istat.conf
    
    if [ -d /usr/local/src ]; then
      cd /usr/local/src
    else
      sudo mkdir /usr/local/src
      cd /usr/local/src
    fi
  
  echo "--------------------------------------"
  echo " downloading $url"
  echo "--------------------------------------"
  
    sudo wget $url
    
  if [ -f $tgz ]; then

    echo "--------------------------------------"
    echo " download complete! extracting..."
    echo "--------------------------------------"
    
    sleep 1
    sudo tar -xzvf $tgz
    
    if [ -d $pkg ]; then
      cd $pkg
    else
      exit 1
    fi
    
    echo "--------------------------------------"
    echo " configuring installer"
    echo "--------------------------------------"
    
      sleep 1
      ./configure --sysconfdir=/etc
    
    echo "--------------------------------------"
    echo " making"
    echo "--------------------------------------"
    
      sleep 1
      make
    
    echo "--------------------------------------"
    echo " installing"
    echo "--------------------------------------"
    
      sleep 1
      sudo make install
    
    echo "--------------------------------------"
    echo " configuring installation"
      
      sleep 1
      
      if id istat > /dev/null 2>&1
      then
        echo "iStat user exists!"
      else
        sudo useradd istat
      fi
      
      if [ -d /var/run/istat ]; then
        sudo chown istat /var/run/istat  
      else
        sudo mkdir /var/run/istat
        sudo chown istat /var/run/istat
      fi
      
      if [ -f $cfg ]; then
        sudo rm $cfg
      fi
      sudo cp $install_dir/istat.conf $cfg
      
    echo "--------------------------------------"
    echo " starting service!"
    
      sleep 1
      sudo /usr/local/bin/istatd -d
    
    
    echo "--------------------------------------"
    echo " installation complete! enjoi!"
    echo "--------------------------------------"
    
    
  else
    echo " download unsuccessful. please make sure version '$istat_version' exists."
    exit 0
  fi
}

while [ -n "$1" ]; do
	case $1 in
		install)
		  if [ -n "$2" ]; then
		    istat_version=$2
		  fi
		  install
		  shift 1
		  break
		  ;;
		-h)
			help
			shift 1
			break
			;;
		-v)
		  echo "$class_name $version"
		  shift 1
      exit 0
		  break
		  ;;
		*)
			echo "error: no such option $1. -h for help";
		  shift 1
      break
			;;
	esac
done
 

if [ -n "$1" ]; then
  help
  exit 0
fi

exit 0
