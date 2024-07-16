# Zoom meeting bot

The following image can be run in a container to launch a zoom meeting and upload the results to a google cloud bucket.

## Project Overview

This project provides a Docker image that runs an Ubuntu-based environment with the XFCE desktop environment accessible via VNC. The image includes Firefox pre-installed. Comment this out of the dockerfile if you don't plan on using a web browser.

Zoom is pre-installed in the image and will connect via the invite link provided, for the amount of time specified.

When the meeting ends, the resulting recording is uploaded to a google cloud bucket via a signed URL. You can generate this signed URL using gcloud CLI.

## Starting the project

First, build the project. **It's important to note that you'll have to choose the architecture that you want to build for, especially if installing Zoom via .deb package**:

`docker buildx build --platform linux/amd64 -t <img_sha>:<tag> .`

Make sure your docker engine is up to date to use buildx.

## env variables

### SIGNED_URL

`gcloud storage sign-url generate gs://your-bucket-name/your-object-name --duration=1h`

### NUM_SECONDS

The number of seconds that this meeting will last (dictates how long we will record for, not when the container finishes / meeting ends)

### MEETING_INVITE_LINK

This is a link that can be found in the zoom application, and is usually sent to meeting attendees.

# VNC into the image


`docker run -p 5901:5901 <img_sha>:<tag>`

If you built for multiple architectures, you can specify: for example, `--platform linux/amd64`. Note that you may build/run the image for any architecture, but if installing zoom via the deb file you'll need to build/run for amd64.

The default password is "password", but this can be configured via the dockerfile
