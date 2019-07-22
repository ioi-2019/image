# ***************** PREPARATION PHASE OF THE ENVIRONMEN

# ---------------------------- Updating sources.list file
cat << EOF >/etc/apt/sources.list
deb http://archive.ubuntu.com/ubuntu/ bionic main restricted universe
deb http://security.ubuntu.com/ubuntu/ bionic-security main restricted universe
deb http://archive.ubuntu.com/ubuntu/ bionic-updates main restricted universe
EOF

# ---------------------------- Adding Missing Repositories

# Code::Blocks
add-apt-repository -y ppa:damien-moore/codeblocks-stable

# Emacs
add-apt-repository ppa:kelleyk/emacs

# Intellij Idea Community
add-apt-repository -y ppa:mmk2410/intellij-idea

# Sublime Text 3
# ---------install GPG key
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
# ---------create add the repository in your sources.list
echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list


# ----------------------------- Adding New Packege Control Systems
apt -y get snap


# ----------------------------- Updating Package List
apt -y update


# ----------------------------- Upgrading the whole System
apt -y upgrade


# ****************** INSTALLATION PHASE OF THE SOFTWARE PACKAGE

# ----------------------------- Compilers
apt -y install gcc=4:7.4.0-1ubuntu2.3 g++=4:7.4.0-1ubuntu2.3
apt -y install openjdk-8-jdk openjdk-8-source

# ----------------------------- Editors and IDEs

# Code::Blocks 16.01(+codeblocks-contrib)
apt -y install codeblocks=16.01+dfsg-2.1 codeblocks-contrib=16.01+dfsg-2.1

# Atom 1.38.2
snap install --stable --classic atom

# Emacs 25.2.2
apt -y install emacs25-common=25.2+1-6
apt -y install emacs25-bin-common=25.2+1-6
apt -y install emacs25=25.2+1-6

# Geany 1.32 + geany-plugins
apt -y install geany=1.32-2 geany-plugins

# Geany 3.28.1
apt -y install gedit=3.28.1-1ubuntu1.2

# Joe 4.6
apt -y install joe=4.6-1

# Kate 17.12.3
apt -y install kate=4:17.12.3-0ubuntu1

# KDevelop 5.2.1
apt -y install kdevelop=4:5.2.1-1ubuntu4

# Nano 2.9.3
apt -y install nano=2.9.3-2

# Vim 8.0 
apt -y install vim=2:8.0.1453-1ubuntu1.1

# Vim-gnome 8.0
apt -y install vim-gnome=2:8.0.1453-1ubuntu1.1

# IntelliJ IDEA Community 2019.1.2
apt -y install intellij-idea-community=2019.1.3-1

# Byobu 5.125
apt -y install byobu=5.125-0ubuntu1

# Sublime Text 3
apt -y install sublime-text

# Eclipse 2019-03(4.11) + JDT & CDT 9.8
snap install --stable --classic
# ---------- JDT

# ---------- CDT 9.8



# ------------------------- Debuggers

# GDB 8.1
apt -y install gdb=8.1-0ubuntu3

# DDD 3.3.12
apt -y install ddd=1:3.3.12-5.1build2

# Valgrind 3.13.0
apt -y install valgrind=1:3.13.0-2ubuntu2.1

# VisualVM 1.4.2
apt -y install visualvm=1.4.2-2~18.04.1



# ---------------------------- Interpreters

# Ruby 2.5.1
apt -y install ruby=1:2.5.1 

# Python 2.7.15 + mathplot
apt -y install python=2.7.15~rc1-1
apt -y install python-pip
pip install matplotlib

# Python 3.6.7 + mathplot
apt -y install python3=3.6.7-1~18.04
apt -y install python3-pip
pip3 install matplotlib

# ---------------------------- Documentations
apt -y install stl-manual openjdk-8-doc python2.7-doc python3.6-doc

# C/CPP reference
wget http://upload.cppreference.com/mwiki/images/7/78/html_book_20151129.zip
unzip html_book_20151129.zip -d /opt/cppref
rm -rf html_book_20151129.zip

# ---------------------------- Other Software

# Firefox 68.0
apt -y install firefox=68.0+build3-0ubuntu0.18.04.1

# Konsole 17.12.3
apt -y install konsole=4:17.12.3-1ubuntu1

# Midnight Commander 4.8.19
apt -y install mc=3:4.8.19-1



