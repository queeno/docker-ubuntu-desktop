FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive
ENV USER root
ENV NO_VNC_HOME /root/noVNC

# install packages
RUN apt-get update && \
    apt-get install -y xfce4 xfce4-goodies tightvncserver terminator wget net-tools firefox software-properties-common python-software-properties && \
    add-apt-repository ppa:wine/wine-builds && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y winehq-staging
    
ADD xstartup /root/.vnc/xstartup
ADD passwd /root/.vnc/passwd

RUN chmod +x /root/.vnc/xstartup
RUN chmod 600 /root/.vnc/passwd

RUN mkdir -p $NO_VNC_HOME/utils/websockify \
    && wget -qO- https://github.com/ConSol/noVNC/archive/consol_1.0.0.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME \
    &&  wget -qO- https://github.com/kanaka/websockify/archive/v0.7.0.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME/utils/websockify \
    && chmod +x -v /root/noVNC/utils/*.sh

CMD /usr/bin/vncserver :1 -geometry 1280x700 -depth 24 && tail -f /root/.vnc/*:1.log && /root/noVNC/utils/launch.sh --vnc localhost:5901 --listen 6901

EXPOSE 5901 6901
