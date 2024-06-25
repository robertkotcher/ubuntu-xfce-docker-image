#!/bin/sh

# Start the VNC server
vncserver -geometry 1280x800 -depth 24

# Keep the container running
tail -f /root/.vnc/*.log
