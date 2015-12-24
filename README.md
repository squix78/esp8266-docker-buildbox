ESP8266 Docker Buildbox
=======================

Dockerfile to create a Ubuntu container containing all the tools needed to compile a simple example for the ESP32


Usage
=====

> git clone https://github.com/squix78/esp32-docker-buildbox.git

> cd esp8266-docker-buildbox/

> docker build -t local/buildbox .

This might take a few minutes. Then run the image with

> docker run -i -t local/buildbox /bin/bash


To flash them onto your ESP32 you can share a folder of your host system by changing the run command:

> docker run --privileged -v=/host/firmwares:/opt/Espressif/Workspace/ESP32_BIN -i -t local/buildbox /bin/bash

This will mount your host systems folder "/host/firmwares" to the build image folder "/opt/firmwares". Of course you are free to change it. Even better would be to pass the usb serial device to the docker container. Then you could flash the image directly from there.
