# Ubuntu XFCE VNC Docker Image

![ubuntu xfce](https://raw.githubusercontent.com/robertkotcher/ubuntu-xfce-docker-image/master/xfce.png)

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

## What is noVNC

noVNC is both a VNC client JavaScript library as well as an application built on top of that library. noVNC runs well in any modern browser including mobile browsers (iOS and Android).

## Building the project

First, build the project. **It's important to note that you'll have to choose the architecture that you want to build for, especially if installing Zoom via .deb package**:

### Simple build

`docker build -t ubuntu-xfce .`

### Specify architecture

`docker buildx build --platform linux/amd64 -t ubuntu-xfce:latest .`

Make sure your docker engine is up to date to use buildx easily.

## Running the container

`docker run -p 5901:5901 -p 6081:6081 ubuntu-xfce:latest`

You can mount to a volume & run as a daemon

`docker run -d -p 5901:5901 -p 6081:6081 -v my_volume:/root ubuntu-xfce`

You can now point the host browser to `http://localhost:6081/vnc.html?host=0.0.0.0&port=6081`, or alternatively use a VNC server and point to localhost:5901.

The default password is "password", but this can be configured via the dockerfile

## Todo

Set up pulseaudio to optionally enable sound (I didn't need it yet so I didn't do it :D)
