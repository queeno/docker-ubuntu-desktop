FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive
ENV USER root
ENV NO_VNC_HOME /root/noVNC

# install packages
RUN apt-get update && \
    apt-get install -y xfce4 xfce4-goodies tightvncserver supervisor terminator wget net-tools firefox software-properties-common python-software-properties && \
    add-apt-repository ppa:wine/wine-builds && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y winehq-staging
    
ADD xstartup /root/.vnc/xstartup
ADD passwd /root/.vnc/passwd

RUN chmod +x /root/.vnc/xstartup
RUN chmod 600 /root/.vnc/passwd

ADD conf /etc/supervisor/conf.d/
ADD supervisor.conf /etc/supervisor/supervisor.conf

RUN mkdir -p $NO_VNC_HOME/utils/websockify \
    && wget -qO- https://github.com/ConSol/noVNC/archive/consol_1.0.0.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME \
    &&  wget -qO- https://github.com/kanaka/websockify/archive/v0.7.0.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME/utils/websockify \
    && chmod +x -v /root/noVNC/utils/*.sh

CMD ["supervisord","-c","/etc/supervisor/supervisor.conf"]

EXPOSE 5901 6901
