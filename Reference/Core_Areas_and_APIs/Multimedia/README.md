---
title: Multimedia
permalink: Reference/Core_Areas_and_APIs/Multimedia/
parent: Core Areas and APIs
layout: default
nav_order: 300
---

Sailfish Multimedia uses QtMultimedia, on top of GStreamer 1.0 supporting the 'base', 'good' and 'bad' plugin collections, built against several open-source codec libraries. The 'ugly' plugin set is not supported for licensing reasons. Additional software codecs are supported by [ffmpeg](https://ffmpeg.org/) and available through GStreamer using the gst-libav plugin.

On libhybris devices, hardware codecs, camera support and hardware video buffers from the Android HAL are exposed in a custom open source GStreamer plugin, [gst-droid](https://github.com/sailfishos/gst-droid), that interacts with a custom Android multimedia service, [droidmedia](https://github.com/sailfishos/droidmedia).

The GStreamer elements provided can be used through QtMultimedia, but also directly:

  - **droidcamsrc** - Camera element wrapping the Android Camera API1, exposing sink pads for viewfinder, photos and video. Camera parameters such as camera device, picture resolution, flash, focus, scene mode are exposed through QtMultimedia. A special 'recorder' mode allows raw video data to be directly fed into hardware codecs in the Android layer, to increase performance.
  - **droidvdec, droidvenc, droidadec, droidaenc** - Wrappers for the Android OMX video and audio codecs provided by the base Android system layer.
  - **droideglsink** - Hardware EGL video display. Can consume Android hardware buffers directly from the camera viewfinder and video decoders, and also propose them to other software video decoders.

Media indexing is provided by [GNOME Tracker](https://wiki.gnome.org/Projects/Tracker/), using its internalffmpeg for video extraction to avoid interfering with the video hardware through GStreamer.

Sailfish uses Pulseaudio for sound support. [Ohm](https://github.com/sailfishos/ohm) handles routing and policy, for example to ensure that media players are paused when a voice call arrives, or when headphones are unplugged.

## Format support

Multimedia formats currently supported by Sailfish. Hardware accelerated codecs are device and license specific, and so may not be present for all devices.

### Video

  - Hardware accelerated: h.265/HEVC, h.264/AVC, h.263/3GPP, MPEG-4 part 2, MPEG-2, VP8, VP9
  - Software codecs from external libraries: Ogg Theora (libtheora), VP8 & VP9 (libvpx)
  - Formats: WebM, Matroska, OGG, MP4, MPEG-PS, MPEG-TS, FLV, AVI, DivX, Quicktime, Motion JPEG 2000
  - Hardware Encoders: h.264/AVC, MPEG-4 part 2

### Audio

  - Software codecs from external libraries: FLAC, Opus, Vorbis, MPEG audio 1,2 & 3 (mpg123), MPEG-4/AAC, Speex
  - Additional software codecs provided by ffmpeg: AC3, Musepack, APE, AIFF, aLaw, muLaw, VP3, 5 & 6.
  - Encoders: Stereo AAC, Opus, FLAC, Vorbis
