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

`docker run -p 5901:5901 wheresmycookie/ubuntu-xfce`

The default password is "password", but this can be configured via the dockerfile
