# Ubuntu XFCE VNC Docker Image

## Project Overview

This project provides a Docker image that runs an Ubuntu-based environment with the XFCE desktop environment accessible via VNC. The image includes Firefox pre-installed. Comment this out of the dockerfile if you don't plan on using a web browser.

## What is XFCE?

XFCE is a lightweight, open-source desktop environment for Unix-like operating systems. It aims to be fast and low on system resources while still being visually appealing and user-friendly. Here are some reasons to choose XFCE over other desktop environments:

- lightweight / fast
- customizeable
- stability

## What is VNC?

VNC (Virtual Network Computing) is a graphical desktop-sharing system that uses the Remote Frame Buffer (RFB) protocol to remotely control another computer. It transmits the keyboard and mouse events from one computer to another, relaying the graphical screen updates back in the other direction, over a network.

this project uses tightvnc VNC server.

## Starting the project

First, build the project. **It's important to note that you'll have to choose the architecture that you want to build for, especially if installing Zoom via .deb package**:

`docker buildx build --platform linux/amd64 -t wheresmycookie/ubuntu-xfce:<tag> .`

Make sure your docker engine is up to date to use buildx.

Now run the image:

`docker run -p 5901:5901 wheresmycookie/ubuntu-xfce`

If you built for multiple architectures, you can specify: for example, `--platform linux/amd64`. Note that you may build/run the image for any architecture, but if installing zoom via the deb file you'll need to build/run for amd64.

The default password is "password", but this can be configured via the dockerfile
