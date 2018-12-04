FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive
ENV USER root

ADD sources.list /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y --no-install-recommends --fix-missing ubuntu-desktop && \
    apt-get install -y --fix-missing gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal && \
    apt-get install -y --fix-missing tightvncserver && \
    mkdir /root/.vnc

ADD xstartup /root/.vnc/xstartup
ADD passwd /root/.vnc/passwd

RUN chmod 600 /root/.vnc/passwd

CMD /usr/bin/vncserver :1 -geometry 1280x800 -depth 24 && tail -f /root/.vnc/*:1.log

EXPOSE 5901
