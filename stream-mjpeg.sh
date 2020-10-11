#!/bin/bash

gst-launch-1.0 -v v4l2src device=/dev/video0 ! image/jpeg,width=1920,height=1080,pixel-aspect-ratio=1/1,framerate=30/1 ! rtpjpegpay ! udpsink host=192.168.0.34 port=5010
