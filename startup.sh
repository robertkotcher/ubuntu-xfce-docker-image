#!/bin/sh
# Create hello.txt on the Desktop
mkdir -p /root/Desktop

firefox "https://us04web.zoom.us/j/3367078931?pwd=NxaVA1gbZbK9t4KU2rjp7SJlMZnue9.1"

# Start the VNC server
vncserver -geometry 1280x800 -depth 24

# Keep the container running
tail -f /root/.vnc/*.log

