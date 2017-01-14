#!/bin/bash

# Installs the indicator on ~/Executables
install -d ~/Executables/CapslockI/
install -d ~/Executables/CapslockI/res/
install ./CapslockI.rb ~/Executables/CapslockI/CapslockI.rb
install -m 664 ./res/capslockOff.png ~/Executables/CapslockI/res/capslockOff.png
install -m 664 ./res/capslockOn.png ~/Executables/CapslockI/res/capslockOn.png

# Sets it to start up on login
cat > ~/.config/autostart/CapslockI.desktop << _EOF_
[Desktop Entry]
Type=Application
Exec=/home/$USER/Executables/CapslockI/CapslockI.rb
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=CapslockI
Name=CapslockI
Comment[en_US]=Capslock key state indicator
Comment=Capslock key state indicator
_EOF_
