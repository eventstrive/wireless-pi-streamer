#!/bin/bash

gst-launch-1.0 alsasrc device=hw:2 ! audioconvert ! audioresample  ! alawenc ! rtppcmapay ! udpsink host=192.168.0.34 port=5011
# gst-launch-1.0 -v alsasrc device=hw:1 provide-clock=true do-timestamp=true ! audio/x-raw,channels=1,depth=24,width=24,rate=48000,payload=96 ! audioconvert ! rtpL24pay ! udpsink host=192.168.0.34 port=5011
# gst-launch-1.0    alsasrc device=hw:0,0                                    ! audio/x-raw,channels=2,depth=24,width=24,rate=48000             ! audioconvert ! rtpL24pay ! udpsink host=192.168.0.34 port=5011