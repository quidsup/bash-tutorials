#!/bin/bash
#Name: Package Manager Tutorial
#Description: Script checks which package manager is being used, and then opens the appropriate function
#  Fill out the list of packages you require. 
#  Note: Package names can differ between Linux Distros
#Video: 

Install_Apt() {
  #Ubuntu
  echo "Preparing to Install Deb Packages with Apt..."
  sudo apt -y install
}
Install_AptGet() {
  #Debian, Ubuntu
  echo "Preparing to Install Deb Packages with Apt-Get..."
  sudo apt-get -y install
}
Install_Aptitude() {
  #Debian, Ubuntu
  echo "Preparing to Install Deb Packages with Aptitude..."
  sudo aptitude -y install
}
Install_Dnf() {
  #Redhat, Fedora
  echo "Preparing to Install RPM packages using Dnf..."
  sudo dnf -y install
}
Install_Pacman() {
  #Arch
  echo "Preparing to Install Arch Packages..."
  sudo pacman -S --noconfirm
}
Install_Slackpkg() {
  #Slackware
  echo "Preparing to Install Slackware Packages..."
  slackpkg install
}
Install_Yum() {
  #Older versions of Redhat, Fedora
  echo "Preparing to Install RPM packages using Yum..."
  sudo yum -y install
}
Install_Zypper() {
  #OpenSuse
  echo "Preparing to Install RPM packages using Zypper..."
  sudo zypper install
}

#Find out which package manager is in use
if [ "$(command -v apt)" ]; then Install_Apt
elif [ "$(command -v apt-get)" ]; then Install_AptGet
elif [ "$(command -v aptitude)" ]; then Install_Aptitude
elif [ "$(command -v dnf)" ]; then Install_Dnf
elif [ "$(command -v pacman)" ]; then Install_Pacman
elif [ "$(command -v slackpkg)" ]; then Install_Slackpkg
elif [ "$(command -v yum)" ]; then Install_Yum
elif [ "$(command -v zypper)" ]; then Install_Zypper
else
  echo "Unknown package manager"
  echo "Install the following packages:"
  echo -e "\tpackage1"
  echo -e "\tpackage2"
  echo
  echo -en "Press any key to continue... "
  read -rn1
  #exit 1 
fi
