#!/bin/bash

# Bash script for building the IOI 2019 contest image | Desktop Link Creation Phase
# Version: 1.2
# http://ioi2019.az/

set -xe

# ******************************* CREATION OF THE DESKTOP ENTRIES AND LOCATING THEM IN THE FOLDERS ON THE DESKTOP

# Changing directory to create desktop entries
cd /usr/share/applications/

# -------------------- Documentations

# Python2.7 documentation entry

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

# End

# Python3.6 documentation entry

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


# End

# C/CPP documentation entry

cat << EOF > c-cpp-doc.desktop
[Desktop Entry]
Type=Application
Name=C/C++ Documentation
Comment=C/C++ Documentation
Icon=firefox
Exec=firefox /opt/cppref/reference/en/index.html
Terminal=false
Categories=Documentation;C;C++;
EOF


# End

# Java documentation entry

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


# End

# STL documentation entry

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

# End

# -------------------- End

# -------------------- Applications

# Eclipse

cat << EOF > eclipse.desktop
[Desktop Entry]
Type=Application
Name=Eclipse Neon
Comment=Eclipse Integrated Development Environment
Icon=/opt/eclipse-4.11/icon.xpm
Exec=eclipse
Terminal=false
Categories=Development;IDE;Java;
EOF

# End

# -------------------- End

# ----------------- Creating appropriet folders to locate entries on the desktop

mkdir -p "$HOME/Desktop/Editors & IDEs"
mkdir -p "$HOME/Desktop/Utils"
mkdir -p "$HOME/Desktop/Docs"

# -------------------- End


# ------------------- Copying Entries to the Folders

# Copy Editors and IDEs

for i in atom codeblocks emacs25 geany gedit intellij-idea-community joe org.kde.kate org.kde.kdevelop sublime_text vim gvim
do
    cp "$i.desktop" "$HOME/Desktop/Editors & IDEs"
done

# End

# Copy Docs

for i in c-cpp-doc stl-manual java-doc python2.7-doc python3.6-doc
do
    cp "$i.desktop" "$HOME/Desktop/Docs"
done

# End

# Copy Utils

for i in firefox gnome-terminal org.kde.konsole mc byobu
do
    cp "$i.desktop" "$HOME/Desktop/Utils"
done

# End

# -------------------- End

# ------------------- Changing ownership of the directories and .desktop files
chown contestant:contestant "$HOME/Desktop/Editors & IDEs"
chown contestant:contestant "$HOME/Desktop/Utils"
chown contestant:contestant "$HOME/Desktop/Docs"
chown contestant:contestant "$HOME/Desktop/Editors & IDEs"/*
chown contestant:contestant "$HOME/Desktop/Utils"/*
chown contestant:contestant "$HOME/Desktop/Docs"/*

# -------------------- End

# ------------------- Adding executative permission to all .desktop files

chmod a+x "$HOME/Desktop/Editors & IDEs"/*
chmod a+x "$HOME/Desktop/Utils"/*
chmod a+x "$HOME/Desktop/Docs"/*

# -------------------- End

# ******************************* END

# ******************************* DESKTOP APPEARANCE CONFIGURATIONS

# -------------------- Installation of required package

apt -y install xvfb

# -------------------- End

# -------------------- Acquiring background image
wget -O /opt/ioi-2019-wallpaper.png "https://raw.githubusercontent.com/ioi-2019/image/master/ioi-2019-wallpaper.png"

# -------------------- Setting background image and others

xvfb-run gsettings set org.gnome.desktop.background primary-color "#000000000000"
xvfb-run gsettings set org.gnome.desktop.background picture-options "spanned"
xvfb-run gsettings set org.gnome.desktop.background picture-uri "file:///opt/ioi-2019-wallpaper.png"

# -------------------- End


