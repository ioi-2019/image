# ******************************* CREATION OF THE DESKTOP ENTRIES AND LOCATING THEM IN FOLDERS ON THE DESKTOP

# -------------------- Changing Directory To Create Desktop Entries
cd /usr/share/applications/

# -------------------- Creating Desktop Entries

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

cat << EOF > atom.desktop
[Desktop Entry]
Version=1.38.2
Type=Application
Name=Atom
Comment=Atom IDE
Categories=IDE;
Exec=/snap/bin/atom
Icon=/snap/atom/232/usr/share/pixmaps/atom.png
Terminal=false
Categories=Development;IDE;
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

# ----------------- Creating Appropriet Folders to Locate Entries on The Desktop
mkdir -p "$HOME/Desktop/Editors & IDEs"
mkdir -p "$HOME/Desktop/Utils"
mkdir -p "$HOME/Desktop/Docs"

# ------------------- Copying Entries to the Folders
# Copy Editors and IDEs
#for i in atom codeblocks emacs25 geany gedit joe org.kde.kate org.kde.kdevelop nano sublime_text
#do
 #   cp "$i.desktop" "$HOME/Desktop/Editors & IDEs"
#done

# Copy Docs
for i in c-cpp-doc stl-manual java-doc python2.7-doc python3.6-doc
do
    cp "$i.desktop" "$HOME/Desktop/Docs"
done

# Copy Utils
for i in firefox ddd  gnome-terminal org.kde.konsole mc byobu
do
    cp "$i.desktop" "$HOME/Desktop/Utils"
done

# ----------------- Changing Ownership
chown -R $USER "$HOME/Desktop/Editors & IDEs"
chown -R $USER "$HOME/Desktop/Utils"
chown -R $USER "$HOME/Desktop/Docs"

# ----------------- Adding execution permission
chmod +x "$HOME/Desktop/Editors & IDEs/*.desktop"
chmod +x "$HOME/Desktop/Utils/*.desktop"
chmod +x "$HOME/Desktop/Docs/*.desktop" 
