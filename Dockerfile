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
    apt-get install -y curl && \
    apt-get install -y pulseaudio && \
    apt-get install -y sox && \
    apt-get install -y libsox-fmt-all && \
    apt-get clean

RUN apt-get install -y autocutsel # copy / paste across vnc
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

# Move zoom config
RUN mkdir -p /root/.config
COPY zoomus.conf /root/.config/zoomus.conf

# Set USER environment variable
ENV USER=root

# Expose VNC port
EXPOSE 5901

# Start the VNC server and create the file on the Desktop
CMD ["/root/startup.sh"]
