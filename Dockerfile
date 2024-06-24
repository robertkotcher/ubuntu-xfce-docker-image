FROM ubuntu:20.04

# Set environment variable to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install packages for xfce and other tools
RUN apt-get update && \
    apt-get install -y tzdata && \
    apt-get install -y xfce4 && \
    apt-get install -y xfce4-goodies && \
    apt-get install -y tightvncserver && \
    apt-get install -y wget && \
    apt-get install -y sudo && \
    apt-get clean

# Install Firefox
RUN apt-get install -y firefox && apt-get clean

# Setup VNC server
RUN mkdir -p /root/.vnc && \
    echo "password" | vncpasswd -f > /root/.vnc/passwd && \
    chmod 600 /root/.vnc/passwd

COPY xstartup /root/.vnc/xstartup
RUN chmod +x /root/.vnc/xstartup

# Copy startup script
COPY startup.sh /root/startup.sh
RUN chmod +x /root/startup.sh

# Set USER environment variable
ENV USER=root

# Expose VNC port
EXPOSE 5901

# Start the VNC server and create the file on the Desktop
CMD ["/root/startup.sh"]

