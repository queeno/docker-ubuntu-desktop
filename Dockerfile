FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y ubuntu-desktop && \
    apt-get install -y tightvncserver

CMD ['vncserver :1 -geometry 1280x800 -depth 24']

EXPOSE 5901
