# docker_clouddrives

Clouddrives in docker | Graphical interface of Alibaba Cloud Drive, Quark Cloud Drive and other software running in docker container, suitable for various Linux or Linux-based NAS, servers without graphical interface

I hope that various software officials can support Linux version as soon as possible

(The image size may have room for improvement)

# Statement

The warehouse only provides the operating environment and does not change any official program. Please download the installation package from the official website

## Tested software (minimum configuration test platform is J1900, non-graphical interface)

- [x] Alibaba Cloud Drive
- [x] Quark Cloud Drive
- [x] WeChat
- [x] NetEase Cloud Music

# Preface

Project based on

[https://github.com/jlesage/docker-baseimage-gui](https://github.com/jlesage/docker-baseimage-gui)

[https://github.com/GloriousEggroll/wine-ge-custom](https://github.com/GloriousEggroll/wine-ge-custom)

Reference to some practices of the following project

[https://github.com/KevinLADLee/baidunetdisk-docker](https://github.com/KevinLADLee/baidunetdisk-docker)

Please install docker yourself

# Instructions
## Use pre-built images
```bash
docker pull tydaytygx/clouddrives:latest

git clone https://github.com/tydaytygx/docker-clouddrives

cd docker-clouddrives

chmod +x startapp.sh

```
## Pull resources and build images locally (optional)
```bash
git clone https://github.com/tydaytygx/docker-clouddrives

cd docker-clouddrives

git clone https://github.com/jlesage/docker-baseimage-gui

cp -r docker-baseimage-gui/rootfs .

chmod +x startapp.sh

docker build -t clouddrives .
```

## Download wine-ge-custom (linux) on the host, unzip it to the config directory, and mount it to the container later
```
# Create a new config folder to put wine-ge-custom
mkdir config

# Automatically download the latest wine-ge-custom and unzip it to config
latest_release=$(wget -qO- https://api.github.com/repos/GloriousEggroll/wine-ge-custom/releases/latest) && \
download_url=$(echo $latest_release | jq -r '.assets[] | select(.name | endswith(".tar.xz")) | .browser_download_url') && \
echo "Downloading from $download_url" && \
wget "$download_url" && \
tar -xvf $(basename "$download_url") -C config && \
rm $(basename "$download_url")

# Or manually download and unzip to ./config in the release interface of https://github.com/GloriousEggroll/wine-ge-custom
```
```yml
services:
clouddrives:
image: clouddrives:latest
container_name: clouddrives
volumes:
- ./config/:/config/
- ./startapp.sh:/startapp.sh
- ./downloads:/config/.wine/drive_c/users/app/Downloads
environment:
- GROUP_ID=1000
- USER_ID=1000
- ENABLE_CJK_FONT=1
- VNC_PASSWORD=YOUR_VERY_STRONG_PASSWORD
- WINEPREFIX=/config/.wine
#- WINEDEBUG=err,+warning
- LANG=C.UTF-8
- LC_ALL=C.UTF-8
deploy:
resources:
limits:
cpus: '2'
memory: '8G'
ports:
- '5801:5800'
- '5901:5900'
logging:
driver: "json-file"
options:
max-size: "10m"
max-file: "3"
restart: always
```
# Start the container

```
docker compose up -d
```

# Install (decompress) the software

# Alibaba Cloud Disk
Download from Alibaba Cloud Disk official website Installation package aDrive.exe

For example
wget --header="Accept: text/html" --user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0" "https://cdn.aliyundrive.net/downloads/apps/desktop/aDrive-6.3.3.exe?spm=aliyundrive.index.0.0.7db16f60JggkiK&file=aDrive-6.3.3.exe"

Use 7z to decompress

```bash
mkdir aDrive

7z x aDrive.exe -oaDrive

cp -r aDrive ./config/.wine/driver_c/users/app/aDrive

```

## Access

Browser access IP:5801

### Graphical startup method

Navigate to C:\users\app\aDrive

Double-click aDrive.exe to start

### Command line startup method

Double-click cmd.exe
```batch

cd c:\users\app\aDrive

aDrive.exe

# Then use the cloud disk as normal

```

# Quark Cloud Drive (Similarly, copy to ./config, VNC access startup, to be supplemented)

[https://github.com/dscharrer/innoextract](https://github.com/dscharrer/innoextract)

Quark Cloud Drive needs to be decompressed using innoextract. The innoextractor installed by apt may be too old. At this time, you can consider downloading the latest build directly from the warehouse

```bash
mkdir quark

mv QuarkCloudDrive.exe quark

# Specific installation package name (you can also use mv name_A name_B to change the file name)

innoextract QuarkCloudDrive.exe

cp -r quark ./config/.wine/drive_c/users/app/
```

## Access

Browser access IP:5801

### Graphical startup method

Navigate to C:\users\app\quark

Double-click QuarkClouddrive.exe to start

### Command line startup method

Double-click cmd.exe

```batch

cd c:\users\app\quark

QuarkClouddrive.exe
```
