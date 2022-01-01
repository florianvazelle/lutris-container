FROM debian:bullseye

# Install wine, pulseaudio and other dependencies
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

# Install lutris
RUN apt update && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y \ 
      wget \
      gnupg && \
    echo "deb http://download.opensuse.org/repositories/home:/strycore/Debian_10/ ./" | tee /etc/apt/sources.list.d/lutris.list && \
    wget -q https://download.opensuse.org/repositories/home:/strycore/Debian_10/Release.key -O- | apt-key add - && \
    apt update && \
    env DEBIAN_FRONTEND=noninteractive apt-get install -y \
      lutris && \
    rm -rf /var/lib/apt/lists/*

# Update PATH to be able to run lutris
ENV PATH "$PATH:/usr/games"

# Run lutris
CMD ["lutris"]