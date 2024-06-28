FROM ubuntu:20.04

# Set environment variable to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install packages for xfce and other tools
RUN apt-get update && \
    apt-get install -y tzdata && \
    apt-get install -y xfce4 && \
    apt-get install -y tightvncserver && \
    apt-get install -y wget && \
    apt-get install -y sudo && \
    apt-get install -y git && \
    apt-get install -y xfce4-terminal && \
    apt-get clean

RUN apt-get install -y autocutsel
RUN apt-get install -y python3 python3-pip
RUN apt-get install firefox -y
RUN apt-get clean

# Setup VNC server
RUN mkdir -p /root/.vnc && \
    echo "password" | vncpasswd -f > /root/.vnc/passwd && \
    chmod 600 /root/.vnc/passwd

COPY xstartup /root/.vnc/xstartup
RUN chmod +x /root/.vnc/xstartup

# Install noVNC
RUN git clone https://github.com/novnc/noVNC.git /root/noVNC

# Copy startup script
COPY startup.sh /root/startup.sh
RUN chmod +x /root/startup.sh

# Set USER environment variable
ENV USER=root

# Expose NoVNC port
EXPOSE 5901
EXPOSE 6081

# Start the VNC server and noVNC
CMD ["/root/startup.sh"]
