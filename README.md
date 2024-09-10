# docker_aliyunpan_aliyundrive
aliyundrive/aliyunpan in docker | docker容器运行的阿里云盘，等软件
# 前言

项目基于

[https://github.com/jlesage/docker-baseimage-gui](https://github.com/jlesage/docker-baseimage-gui)

[https://github.com/GloriousEggroll/wine-ge-custom](https://github.com/GloriousEggroll/wine-ge-custom)

参考了下面这个项目的部分做法

[https://github.com/KevinLADLee/baidunetdisk-docker](https://github.com/KevinLADLee/baidunetdisk-docker)


请自行安装docker

# 使用说明
## 拉取资源并构建镜像
```bash 
git clone https://github.com/tydaytygx/docker-clouddrives

cd docker-clouddrives

git clone https://github.com/jlesage/docker-baseimage-gui

cp -r docker-baseimage-gui/rootfs .

chmod +x startapp.sh

docker build -t clouddrives .
```

## 在宿主机上下载，稍后挂载到容器中
```
# 自动下载最新的wine-ge-custom并解压到 config
latest_release=$(wget -qO- https://api.github.com/repos/GloriousEggroll/wine-ge-custom/releases/latest) && \
    download_url=$(echo $latest_release | jq -r '.assets[] | select(.name | endswith(".tar.xz")) | .browser_download_url') && \
    echo "Downloading from $download_url" && \
    wget "$download_url" && \
    tar -xvf $(basename "$download_url") -C config && \
    rm $(basename "$download_url")

# 或者在 https://github.com/GloriousEggroll/wine-ge-custom 的 release界面手动下载并解压到/config
```

```yml
services:
  quark:
    image: clouddrives:latest
    container_name: clouddrives
    volumes:
      - ./config/:/config/
      - ./startapp.sh:/startapp.sh
    environment:
      - GROUP_ID=1000
      - USER_ID=1000
      - ENABLE_CJK_FONT=1
      - VNC_PASSWORD=YOUR_VERY_STRONG_PASSWORD
      - WINEPREFIX=/config/.wine
      - WINEDEBUG=err,+warning
      - LANG=C.UTF-8
      - LC_ALL=C.UTF-8

    ports:
      - '5801:5800'
      - '5901:5900'

    restart: always
```
# 启动容器

```
docker compose up -d
```

# 阿里云盘
前往阿里云盘官网下载 安装包aDrive.exe

例如
wget  --header="Accept: text/html" --user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0" “https://cdn.aliyundrive.net/downloads/apps/desktop/aDrive-6.3.3.exe?spm=aliyundrive.index.0.0.7db16f60JggkiK&file=aDrive-6.3.3.exe”


使用7z解压

```bash
mkdir aDrive

7z x aDrive.exe -oaDrive

cp -r aDrive /config/.wine/driver_c/users/app/aDrive

```


# 访问
浏览器访问IP:5801

双击cmd.exe
```batch

cd c:/users/app/aDrive

aDrive.exe

# 然后像正常使用云盘一样即可
```

# 夸克网盘 （同理，复制并使用cmd启动，待补充）
[https://github.com/dscharrer/innoextract](https://github.com/dscharrer/innoextract)

夸克网盘需要使用innoextract解压，由apt安装的innoextractor可能过旧，这时可以考虑直接从仓库下载最新构建

innoextract QuarkCloudDrive.exe





