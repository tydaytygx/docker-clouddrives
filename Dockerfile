FROM jlesage/baseimage-gui:ubuntu-22.04-v4.6

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=":1"
ENV ENABLE_CJK_FONT=1
ENV TZ=Asia/Shanghai
COPY ./rootfs /
COPY ./startapp.sh /startapp.sh
RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y --no-install-recommends wget curl  \
                          ca-certificates \
                          desktop-file-utils    \
                          libasound2-dev        \
                          locales               \
                          fonts-wqy-zenhei      \   
                          libgtk-3-0            \
                          libnotify4            \
                          libnss3               \
                          libxss1               \
                          libxtst6              \
                          xdg-utils             \
                          libatspi2.0-0         \
                          libuuid1              \  
                          libappindicator3-1    \
                          libsecret-1-0         \
                          wget                  \
                          sudo                  \
                          bash                  \
                          x11-utils             \
                          dbus                  \
                          dbus-x11              \
                          xvfb                  \
                          x11vnc                \
                          winbind               \
                          zenity                \
                          libvulkan1            \
                          libgl1-mesa-dri:i386 mesa-vulkan-drivers mesa-vulkan-drivers:i386 \
                          x11-xserver-utils xorg xserver-xorg x11-apps x11-utils \
                          git make \
                          cabextract \
                          udev \
    && wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources \
    && mkdir -pm755 /etc/apt/keyrings \
    && wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key \
    && apt update \
    && apt install --install-recommends -y winehq-devel \
#    && apt upgrade -y \
#    && mkdir /opt/wine-stable/share/wine/mono && wget -O - https://dl.winehq.org/wine/wine-mono/9.3.0/wine-mono-9.3.0-x86.tar.xz | tar -xJv -C /opt/wine-stable/share/wine/mono \
#    && mkdir /opt/wine-stable/share/wine/gecko && wget -O /opt/wine-stable/share/wine/gecko/wine-gecko-2.47.1-x86.msi https://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86.msi \   
    && rm -rf /var/lib/apt/lists/*

# build and install  winetricks
#RUN git clone https://github.com/Winetricks/winetricks.git /tmp/winetricks \
#    && cd /tmp/winetricks \
#    && sudo make install \
#    && rm -rf /tmp/winetricks

#RUN \
#    APP_ICON_URL='https://raw.githubusercontent.com/KevinLADLee/baidunetdisk-docker/master/logo.png' && \
#    install_app_icon.sh "$APP_ICON_URL"

#COPY rootfs/ /

ENV APP_NAME="quark" \
    S6_KILL_GRACETIME=8000

# Configure locale for unicode
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
WORKDIR /config

# Define mountable directories.
VOLUME ["/config"]
VOLUME ["/downloads"]
