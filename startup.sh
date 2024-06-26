#!/bin/sh

# Start the VNC server
vncserver -geometry 1280x800 -depth 24

# Keep the container running
# tail -f /root/.vnc/*.log

echo sleeping for 5s
sleep 5

# Install zoom
wget -O /tmp/zoom.deb https://zoom.us/client/6.1.0.198/zoom_amd64.deb
apt install /tmp/zoom.deb -y

# Join meeting
# xdg-open "zoommtg://zoom.us/join?action=join&confno=3367078931&pwd=NxaVA1gbZbK9t4KU2rjp7SJlMZnue9.1&uname=robert"

tail -f /root/.vnc/*.log
