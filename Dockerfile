FROM ubuntu:12.04

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q git autoconf screen sudo build-essential unzip gperf bison flex vim texinfo libtool libncurses5-dev wget gawk libc6-dev-i386 python-serial libexpat-dev
RUN useradd -d /opt/Espressif -m -s /bin/bash esp8266
RUN echo "esp8266 ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/esp8266
RUN chmod 0440 /etc/sudoers.d/esp8266
RUN su esp8266 -c "cd /opt/Espressif/ && git clone -b lx106 git://github.com/jcmvbkbc/crosstool-NG.git"
RUN su esp8266 -c "cd /opt/Espressif/crosstool-NG && ./bootstrap && ./configure --prefix=`pwd` && make && sudo make install"
RUN su esp8266 -c "cd /opt/Espressif/crosstool-NG && ./ct-ng xtensa-lx106-elf"
RUN su esp8266 -c "cd /opt/Espressif/crosstool-NG && ./ct-ng build"
RUN chmod a+rw /opt/Espressif/
RUN su esp8266 -c "wget -O /tmp/esp_iot_sdk_v0.9.3_14_11_21.zip https://github.com/esp8266/esp8266-wiki/raw/master/sdk/esp_iot_sdk_v0.9.3_14_11_21.zip"
RUN su esp8266 -c "wget -O /tmp/esp_iot_sdk_v0.9.3_14_11_21_patch1.zip https://github.com/esp8266/esp8266-wiki/raw/master/sdk/esp_iot_sdk_v0.9.3_14_11_21_patch1.zip"
RUN su esp8266 -c "cd /tmp; unzip esp_iot_sdk_v0.9.3_14_11_21.zip"
RUN su esp8266 -c "cd /tmp; unzip -o esp_iot_sdk_v0.9.3_14_11_21_patch1.zip"
RUN su esp8266 -c "cd /tmp; mv esp_iot_sdk_v0.9.3/ /opt/Espressif/ESP8266_SDK"
RUN su esp8266 -c "ls -altr /opt/Espressif/ESP8266_SDK"
RUN su esp8266 -c "mv /tmp/License /opt/Espressif/ESP8266_SDK/"
RUN su esp8266 -c "cd /opt/Espressif/ESP8266_SDK && sed -i -e 's/xt-ar/xtensa-lx106-elf-ar/' -e 's/xt-xcc/xtensa-lx106-elf-gcc/' -e 's/xt-objcopy/xtensa-lx106-elf-objcopy/' Makefile"
RUN su esp8266 -c "cd /opt/Espressif/ESP8266_SDK && mv examples/IoT_Demo ."
RUN su esp8266 -c "cd /opt/Espressif/ESP8266_SDK && wget -O lib/libc.a https://github.com/esp8266/esp8266-wiki/raw/master/libs/libc.a"
RUN su esp8266 -c "cd /opt/Espressif/ESP8266_SDK && wget -O lib/libhal.a https://github.com/esp8266/esp8266-wiki/raw/master/libs/libhal.a"
RUN su esp8266 -c "cd /opt/Espressif/ESP8266_SDK && wget -O include.tgz https://github.com/esp8266/esp8266-wiki/raw/master/include.tgz"
RUN su esp8266 -c "cd /opt/Espressif/ESP8266_SDK && tar -xvzf include.tgz"
RUN su esp8266 -c "wget -q http://filez.zoobab.com/esp8266/esptool-0.0.2.zip -O ~/ESP8266_SDK/esptool-0.0.2.zip"
RUN su esp8266 -c "cd ~/ESP8266_SDK; unzip esptool-0.0.2.zip"
RUN su esp8266 -c "cd ~/ESP8266_SDK/esptool; sed -i 's/WINDOWS/LINUX/g' Makefile; make"
RUN su esp8266 -c "echo 'PATH=/opt/Espressif/ESP8266_SDK/esptool:$PATH' >> ~/.bashrc"
RUN ln -s /opt/Espressif/ESP8266_SDK/esptool/esptool /usr/bin/esptool
RUN su esp8266 -c "cd ~/ && git clone https://github.com/themadinventor/esptool esptool-py"
RUN su esp8266 -c "ln -s /opt/Espressif/esptool-py/esptool.py /opt/Espressif/crosstool-NG/builds/xtensa-lx106-elf/bin/"
RUN su esp8266 -c "cd /opt/Espressif && git clone https://github.com/esp8266/source-code-examples.git"
