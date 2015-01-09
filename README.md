ESP8266 Docker Buildbox
=======================

Dockerfile to create a Ubuntu container containing all the tools needed to compile a simple example for the ESP8266
See full description here: http://blog.squix.ch/2015/01/esp8266-using-docker-to-setup-build.html

Usage
=====

> git clone https://github.com/squix78/esp8266-docker-buildbox.git
> cd esp8266-docker-buildbox/
> docker build -t local/buildbox .

This might take a few minutes. Then run the image with

> docker run -i -t local/buildbox /bin/bash

To build the blinky example do:

> su - esp8266
> cd source-code-examples/blinky/
> make

which will give you 0x00000.bin and 0x40000.bin.

To flash them onto your ESP8266 you can share a folder of your host system by adding changing the run command:

> docker run --privileged -v=/host/firmwares:/opt/firmwares -i -t local/buildbox /bin/bash

This will mount your host systems folder "/host/firmwares" to the build image folder "/opt/firmwares". Of course you are free to change it. Even better would be to pass the usb serial device to the docker container. Then you could flash the image directly from there. But I couldn't get to work yet

Todo
====
- Pass the usb serial device to the docker image
- Create more Dockerfiles with recent SDK versions
