#!/bin/bash
# Start the VNC server
vncserver -geometry 1280x800 -depth 24

# Start autocutsel to sync clipboard
autocutsel -fork

# Start websockify and noVNC
websockify --web /opt/novnc --wrap-mode=ignore 6080 localhost:5901
