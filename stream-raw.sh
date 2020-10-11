#!/bin/bash

gst-launch-1.0 -v v4l2src device=/dev/video0 ! video/x-raw,framerate=30/1,width=640,height=360 ! videoconvert ! rtpvrawpay ! gdppay ! udpsink host=192.168.0.34 port=5010
