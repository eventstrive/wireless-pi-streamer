# Wireless Pi Streamer (WIP)
This project provides scripts and all instructions to stream HDMI inputs, USB-Webcams and Audio inputs over the network for use in OBS.

## TODO
- Automated + interactive setup script for Pi
- Setup scripts for Windows and MacOS
- Ability to stream HDMI and Camera audio
- Sync video and audio streams by timestamp

## Setup
### Streaming PC
1. The streaming PC has to have a unique IP address in the same network as the raspberry pi so that all Pis can stream directly to this IP.
2. Install gstreamer including all necessary plugins

### OBS
For OBS you will need the [obs-gstreamer plugin](https://github.com/fzwoch/obs-gstreamer) to receive all media streams.

### Raspberry Pi
1. Enable SSH
2. Set up password and wifi for Raspberry Pi
3. Install gstreamer including all necessary plugins
4. Setup environment variables for the Exact host and port, Cam ID (which generates hostname and the IP address range 50{CAM_ID}x)
5. Configure streaming scripts for autostart

## Stream Instructions
### HDMI Input (Screen or Professional Camera)
To stream an HDMI input we are usign a [USB HDMI Capture Stick](https://de.aliexpress.com/item/1005001418537929.html) which make the HDMI input available via a new video and audio input.

The stream already has a low latency (I read about 200ms) but for an even lower latency it might work to use a [HDMI to CSI-2 bridge](https://de.aliexpress.com/item/4000102166176.html) with the [instruction for the Pi Camera](#pi-camera) or to use another and more expensive streaming card which has lower latency.

The latency for the mentioned streaming stick can be reduced by changing the resolution to 720p instead 1080p.

#### Raspberry Pi:

```bash
./stream-mjpeg.sh
```

#### OBS GStreamer Source

```bash
udpsrc port=5010 ! application/x-rtp,encoding-name=JPEG,payload=26 ! rtpjpegdepay ! jpegdec ! video.
```

### USB Webcam
A USB webcam like the Logitech C922 makes the video input available using an x-raw video stream. For this you need another script than for the HDMI input.

#### Raspberry Pi:

```bash
./stream-raw.sh
```

#### OBS GStreamer Source

```bash
udpsrc port=5010 ! gdpdepay  ! rtpvrawdepay ! videoconvert ! video.
```

### Pi Camera
For the Pi Camera there already is [another project](https://github.com/hotsparklab/raspberry-pi-udp-camera) which provides a script including instructions for OBS.

### Audio Input (WIP)
To stream an audio input we are usign a [USB Audio card](https://de.aliexpress.com/item/32721660686.html) which is natively supported by Raspberry Pi OS.

#### Raspberry Pi:

```bash
./stream-audio.sh
```

#### OBS GStreamer Source

```bash
udpsrc port=5011 caps="application/x-rtp" ! rtppcmadepay ! alawdec ! audio.
```
or
```bash
udpsrc port=5011 ! "application/x-rtp,media=(string)audio, clock-rate=(int)48000, channels=1, payload=(int)96" ! rtpjitterbuffer latency=35 ! rtpL24depay ! audioconvert ! jackaudiosink  buffer-time=35000
```

## Port overview

The `x` in the port stands for the specific Raspberry Pi. Each Pi should get an unique ID to avoid port collisions.

- 50x0 - video
- 50x1 - audio