#!/usr/bin/env bash

# directory for application output
# will live at /root/out
mkdir -p out

echo "============================================================"
echo $NUM_SECONDS
echo $SIGNED_URL
echo $MEETING_INVITE_LINK
echo "============================================================"

# env variables:
# - NUM_SECONDS: number of seconds to record for
# - SIGNED_URL: a URL where this audio file can be uploaded
NUM_SECONDS=${NUM_SECONDS:-0}
if [[ -z "$SIGNED_URL" ]]; then
  echo "SIGNED_URL environment variable is not set or is empty."
  exit 1
fi

setup-pulseaudio() {
  # Check if pulseaudio is already running
  if pgrep -x "pulseaudio" > /dev/null
  then
    echo "PulseAudio is already running."
    return
  fi

  echo "Setting up PulseAudio..."

  # Enable dbus
  if [[ ! -d /var/run/dbus ]]; then
    mkdir -p /var/run/dbus
    dbus-uuidgen > /var/lib/dbus/machine-id
    dbus-daemon --config-file=/usr/share/dbus-1/system.conf --print-address
  fi

  usermod -G pulse-access,audio root

  # Cleanup to be "stateless" on startup, otherwise pulseaudio daemon can't start
  rm -rf /var/run/pulse /var/lib/pulse /root/.config/pulse/
  mkdir -p ~/.config/pulse/ && cp -r /etc/pulse/* "$_"

  pulseaudio -D --exit-idle-time=-1 --system --disallow-exit

  # Create a virtual speaker output
  pactl load-module module-null-sink sink_name=SpeakerOutput
  pactl set-default-sink SpeakerOutput
  pactl set-default-source SpeakerOutput.monitor

  # Print PulseAudio sinks and sources for debugging
  echo "PulseAudio Sinks:"
  pactl list sinks short
  echo "PulseAudio Sources:"
  pactl list sources short
}

start_zoom_meeting() {
  # Check if Zoom is already installed
  if ! command -v zoom &> /dev/null
  then
    echo "Zoom is not installed. Installing Zoom..."
    wget -O /tmp/zoom.deb https://zoom.us/client/latest/zoom_amd64.deb
    sudo apt install /tmp/zoom.deb -y
  else
    echo "Zoom is already installed."
  fi

  # Join meeting
  xdg-open $MEETING_INVITE_LINK

  # Capture the PID of the Zoom process
  sleep 10  # give it some time to start
  ZOOM_PID=$(pgrep -f zoom)
  echo "Zoom PID is $ZOOM_PID"
}

record_audio() {
  # Start recording audio from the virtual sink's monitor to a file
  parecord --file-format=wav --device=SpeakerOutput.monitor out/meeting_audio.wav &
  
  # Keep track of parecord's PID to stop it later
  RECORD_PID=$!
  
  echo "Parecord PID is $RECORD_PID"
}

## main

export DISPLAY=:1.0

vncserver -geometry 1280x800 -depth 24

setup-pulseaudio &> /dev/null || exit

start_zoom_meeting
record_audio

sleep $NUM_SECONDS

kill $RECORD_PID
kill $ZOOM_PID

curl -X PUT -T out/meeting_audio.wav "$SIGNED_URL"

sleep 5