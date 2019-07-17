#!/bin/bash

# Bash script for installing softwares
# Version: 1.1
# http://ioi2019.az/

# to show installation process step by step on the terminal
set -xe

# if #LIVE_BUILD variable not empty
if [ -z $LIVE_BUILD ]
then
    export USER=ioi2019
    export HOME=/home/$USER
else
    export USER=root
    export HOME=/etc/skel
fi


# ----- Initilization -----
# I have changed xenial to bionic since Ubuntu 18.04 is bionic but not sure about what it does
cat << EOF >/etc/apt/sources.list
deb http://archive.ubuntu.com/ubuntu/ bionic main restricted universe
deb http://security.ubuntu.com/ubuntu/ bionic-security main restricted universe
deb http://archive.ubuntu.com/ubuntu/ bionic-updates main restricted universe
EOF


# Add missing repositories
add-apt-repository -y ppa:damien-moore/codeblocks-stable # NOT SURE IF WORKING
apt-add-repository -y ppa:mmk2410/intellij-idea
add-apt-repository -y ppa:webupd8team/atom # THIS DID NOT SUCCESS TOO
apt-add-repository -y ppa:brightbox/ruby-ng
add-apt-repository ppa:webupd8team/java # I ADDED THIS HOWEVER IT SAYS BROKEN WHEN I TRIED TO RUN

# Update packages list
apt -y update
apt -y purge thunderbird example-content

# Upgrade everything if needed
apt -y upgrade


# ----- Install software from Ubuntu repositories -----

# Compilers
apt -y install gcc-=7.4 g++=7.4 openjdk-8-jdk openjdk-8-source

# Editors and IDEs
# Firtsly I have tried  to add repository of atom and install there but it didn't success
# https://snapcraft.io/install/atom/ubuntu
apt -y install snapd
snap -y install atom --classic
# still I live it here
apt -y install atom=1.38.2

apt -y install codeblocks=16.01 codeblocks-contrib eclipse=4.11 emacs=25.2.2 geany=1.32 geany-plugins
apt -y install gedit=3.28.1 joe=4.6 kate=17.12.3 kdevelop=5.2.1 nano=2.9.3 vim=8.0 vim-gnome=8.0 
apt -y install intellij-idea-community=2019.1.2
# Digital Oceans documentation on how to install and setup byobu
# https://www.digitalocean.com/community/tutorials/how-to-install-and-use-byobu-for-terminal-management-on-ubuntu-16-04
apt -y install byobu=5.125

# Debuggers
apt -y install gdb=8.1 ddd=3.3.12 valgrind=3.13.0 visualvm=1.4.2

# Interpreters
apt -y install python2.7 python3.6 ruby2.5

# Installing matplotlib library to both versions of python
python2.7 -m pip install -U pip
python2.7 -m pip install -U matplotlib

python3.6 -m pip install -U pip
python3.6 -m pip install -U matplotlib

# Documentation
apt -y install stl-manual openjdk-8-doc python2.7-doc python3.6-doc

# Other Software
apt -y install firefox=67.0 konsole=7.12.3 mc=4.8 byobu=5.125


# ----- Install software not found in Ubuntu repositories -----

cd /tmp/

# CPP Reference
wget http://upload.cppreference.com/mwiki/images/7/78/html_book_20151129.zip
unzip html_book_20151129.zip -d /opt/cppref


# Eclipse 4.11 and CDT plugins


# Sublime Text 3
wget https://download.sublimetext.com/sublime-text_build-3126_amd64.deb
dpkg -i sublime-text_build-3126_amd64.deb
# Update C++ build command
# We need to get this file to our server
wget http://ioi2017.org/files/htc/C++.sublime-package
mv C++.sublime-package /opt/sublime_text/Packages

# ----- Create desktop entries -----

cd /usr/share/applications/

cat << EOF > python3.6-doc.desktop
[Desktop Entry]
Type=Application
Name=Python 3.6 Documentation
Comment=Python 3.6 Documentation
Icon=firefox
Exec=firefox /usr/share/doc/python3.6/html/index.html
Terminal=false
Categories=Documentation;Python3.6;
EOF

cat << EOF > python2.7-doc.desktop
[Desktop Entry]
Type=Application
Name=Python 2.7 Documentation
Comment=Python 2.7 Documentation
Icon=firefox
Exec=firefox /usr/share/doc/python2.7/html/index.html
Terminal=false
Categories=Documentation;Python2.7;
EOF

# cat << EOF > eclipse.desktop
# [Desktop Entry]
# Type=Application
# Name=Eclipse Neon
# Comment=Eclipse Integrated Development Environment
# Icon=/opt/eclipse-4.6/icon.xpm
# Exec=eclipse
# Terminal=false
# Categories=Development;IDE;Java;
# EOF

cat << EOF > cpp-doc.desktop
[Desktop Entry]
Type=Application
Name=C++ Documentation
Comment=C++ Documentation
Icon=firefox
Exec=firefox /opt/cppref/reference/en/index.html
Terminal=false
Categories=Documentation;C++;
EOF

cat << EOF > java-doc.desktop
[Desktop Entry]
Type=Application
Name=Java Documentation
Comment=Java Documentation
Icon=firefox
Exec=firefox /usr/share/doc/openjdk-8-doc/api/index.html
Terminal=false
Categories=Documentation;Java;
EOF

cat << EOF > stl-manual.desktop
[Desktop Entry]
Type=Application
Name=STL Manual
Comment=STL Manual
Icon=firefox
Exec=firefox /usr/share/doc/stl-manual/html/index.html
Terminal=false
Categories=Documentation;STL;
EOF

mkdir -p "$HOME/Desktop/Editors & IDEs"
mkdir -p "$HOME/Desktop/Utils"
mkdir -p "$HOME/Desktop/Docs"

chown $USER "$HOME/Desktop/Editors & IDEs"
chown $USER "$HOME/Desktop/Utils"
chown $USER "$HOME/Desktop/Docs"

# Copy Editors and IDEs
for i in gedit codeblocks emacs24 byobu atom geany org.kde.kate sublime_text eclipse code vim gvim nano kde4/kdevelop intellij-idea-community
do
    cp "$i.desktop" "$HOME/Desktop/Editors & IDEs"
done

# Copy Docs
for i in cpp-doc stl-manual java-doc python2.7-doc python3.6-doc
do
    cp "$i.desktop" "$HOME/Desktop/Docs"
done

# Copy Utils
for i in ddd gnome-calculator gnome-terminal mc org.kde.konsole
do
    cp "$i.desktop" "$HOME/Desktop/Utils"
done

chmod a+x "$HOME/Desktop/Editors & IDEs"/*
chmod a+x "$HOME/Desktop/Utils"/*
chmod a+x "$HOME/Desktop/Docs"/*

# I havent touched this part
# Set desktop settings
apt-get install -y xvfb
if [ -z $LIVE_BUILD ]
then
    wget -O /opt/wallpaper.png "http://ioi2017.org/files/htc/wallpaper.png"
fi
xvfb-run gsettings set org.gnome.desktop.background primary-color "#000000000000"
xvfb-run gsettings set org.gnome.desktop.background picture-options "spanned"
xvfb-run gsettings set org.gnome.desktop.background picture-uri "file:///opt/wallpaper.png"