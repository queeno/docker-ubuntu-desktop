# Ubuntu Desktop Dockerfile

Docker container for Ubuntu 16.04 including ubuntu-desktop and vncserver.

# How to run

`docker run -p 5901:5901 queeno/ubuntu-desktop`

and then connect to:

`vnc://<host>:5901` via VNC client.

The VNC password is `password`.
