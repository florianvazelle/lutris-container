FROM debian:bullseye

RUN apt-get update && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      policykit-1-gnome && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      dbus-x11 \
      lxde \
      lxlauncher \
      lxmenu-data \
      lxtask \
      procps \
      psmisc

# GTK 2 and 3 settings for icons and style, wallpaper
RUN echo '\n\
gtk-theme-name="Raleigh"\n\
gtk-icon-theme-name="nuoveXT2"\n\
' > /etc/skel/.gtkrc-2.0 && \
\
mkdir -p /etc/skel/.config/gtk-3.0 && \
echo '\n\
[Settings]\n\
gtk-theme-name="Raleigh"\n\
gtk-icon-theme-name="nuoveXT2"\n\
' > /etc/skel/.config/gtk-3.0/settings.ini && \
\
mkdir -p /etc/skel/.config/pcmanfm/LXDE && \
echo '\n\
[*]\n\
wallpaper_mode=stretch\n\
wallpaper_common=1\n\
wallpaper=/usr/share/lxde/wallpapers/lxde_blue.jpg\n\
' > /etc/skel/.config/pcmanfm/LXDE/desktop-items-0.conf && \
\
mkdir -p /etc/skel/.config/libfm && \
echo '\n\
[config]\n\
quick_exec=1\n\
terminal=lxterminal\n\
' > /etc/skel/.config/libfm/libfm.conf && \
\
mkdir -p /etc/skel/.config/openbox/ && \
echo '<?xml version="1.0" encoding="UTF-8"?>\n\
<theme>\n\
  <name>Clearlooks</name>\n\
</theme>\n\
' > /etc/skel/.config/openbox/lxde-rc.xml && \
\
mkdir -p /etc/skel/.config/ && \
echo '[Added Associations]\n\
text/plain=mousepad.desktop;\n\
' > /etc/skel/.config/mimeapps.list

RUN echo "deb http://deb.debian.org/debian buster contrib" >> /etc/apt/sources.list && \
    env DEBIAN_FRONTEND=noninteractive dpkg --add-architecture i386 && \
    apt-get update && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y \
      fonts-wine \
      locales \
      ttf-mscorefonts-installer \
      wget \
      winbind \
      winetricks && \
    mkdir -p /usr/share/wine/gecko && \
    cd /usr/share/wine/gecko && \
      wget https://dl.winehq.org/wine/wine-gecko/2.47/wine_gecko-2.47-x86.msi && \
      wget https://dl.winehq.org/wine/wine-gecko/2.47/wine_gecko-2.47-x86_64.msi && \
    mkdir -p /usr/share/wine/mono && \
    cd /usr/share/wine/mono && \
      wget https://dl.winehq.org/wine/wine-mono/4.7.1/wine-mono-4.7.1.msi && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y \
      gettext \
      gnome-icon-theme \
      q4wine \
      xterm && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y \
      libxv1 \
      mesa-utils \
      mesa-utils-extra && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      libpulse0 \
      pavucontrol \
      pasystray
      
RUN env DEBIAN_FRONTEND=noninteractive apt-get install -y \
      xfwm4 && \
    mkdir -p /etc/skel/.config/lxsession/LXDE && \
    echo '[Session]\n\
window_manager=xfwm4\n\
' >/etc/skel/.config/lxsession/LXDE/desktop.conf

# Install lutris

RUN apt update && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y \ 
      wget \
      gnupg && \
    echo "deb http://download.opensuse.org/repositories/home:/strycore/Debian_10/ ./" | tee /etc/apt/sources.list.d/lutris.list && \
    wget -q https://download.opensuse.org/repositories/home:/strycore/Debian_10/Release.key -O- | apt-key add - && \
    apt update && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y \
      lutris

ENV PATH "$PATH:/usr/games"

# Define start script

RUN echo "#! /bin/bash\n\
echo 'x11docker/lxde: If the panel does not show an approbate menu\n\
  and you encounter high CPU usage (seen with kata-runtime),\n\
  please run with option --init=systemd.\n\
' >&2 \n\
startlxde\n\
" >/usr/local/bin/start && chmod +x /usr/local/bin/start

CMD ["/usr/local/bin/start"]