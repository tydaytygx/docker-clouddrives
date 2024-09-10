# docker_aliyunpan_aliyundrive
aliyundrive/aliyunpan in docker | docker容器运行的阿里云盘，等软件
# 前言

项目基于

[https://github.com/jlesage/docker-baseimage-gui](https://github.com/jlesage/docker-baseimage-gui)

[https://github.com/GloriousEggroll/wine-ge-custom](https://github.com/GloriousEggroll/wine-ge-custom)

参考了下面这个项目的部分做法

[https://github.com/KevinLADLee/baidunetdisk-docker](https://github.com/KevinLADLee/baidunetdisk-docker)

# 使用说明
```bash
git clone https://github.com/jlesage/docker-baseimage-gui

cp -r docker-baseimage-gui/rootfs .

git clone https://github.com/tydaytygx/docker_aliyunpan_aliyundrive

docker build -t aliyundrive .
```



