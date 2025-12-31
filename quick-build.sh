#!/bin/bash

# 快速构建脚本 - 适用于GitHub Actions和本地构建

set -e

echo "=== OpenWrt TL-WR842N v3 快速构建脚本 ==="
echo "目标: 生成集成CUPS打印服务的OpenWrt固件"
echo ""

# 检查是否在GitHub Actions环境中
if [ "$GITHUB_ACTIONS" = "true" ]; then
    echo "运行在GitHub Actions环境中"
    BUILD_DIR="$GITHUB_WORKSPACE"
else
    echo "运行在本地环境中"
    BUILD_DIR="$(pwd)"
fi

cd "$BUILD_DIR"

# 安装依赖（本地环境）
if [ "$GITHUB_ACTIONS" != "true" ]; then
    echo "安装构建依赖..."
    sudo apt-get update
    sudo apt-get install -y \
        build-essential ccache ecj fastjar file g++ gawk \
        gettext git java-propose-classpath libelf-dev libncurses5-dev \
        libncursesw5-dev libssl-dev python python2.7-dev python3 unzip wget \
        python3-distutils python3-setuptools python3-dev rsync subversion \
        swig time xsltproc zlib1g-dev
fi

# 克隆或更新OpenWrt源码
if [ ! -d "openwrt" ]; then
    echo "克隆OpenWrt源码..."
    git clone --depth=1 https://github.com/openwrt/openwrt.git openwrt
    cd openwrt
    git checkout openwrt-22.03
else
    echo "更新OpenWrt源码..."
    cd openwrt
    git pull
fi

# 更新feeds
echo "更新feeds..."
./scripts/feeds update -a
./scripts/feeds install -a

# 下载自定义包
echo "下载自定义包..."
[ -d "package/luci-app-cupsd" ] || git clone https://github.com/project-openwrt/luci-app-cupsd.git package/luci-app-cupsd
[ -d "package/foo2zjs" ] || git clone https://github.com/kanhoo/foo2zjs-openwrt.git package/foo2zjs

# 应用配置文件
echo "应用配置文件..."
cp "$BUILD_DIR/configs/wr842n-v3.config" .config

# 复制自定义文件
echo "复制自定义文件..."
cp -r "$BUILD_DIR/files/"* files/

# 配置
echo "配置构建..."
make defconfig

# 下载源码
echo "下载源码..."
make download -j$(nproc)

# 编译
echo "开始编译..."
make -j$(nproc) V=s

# 复制固件
echo "复制固件..."
mkdir -p "$BUILD_DIR/firmware"
cp bin/targets/ar71xx/generic/*.bin "$BUILD_DIR/firmware/"

# 显示结果
echo ""
echo "=== 构建完成 ==="
echo "固件文件:"
ls -la "$BUILD_DIR/firmware/"*.bin

# GitHub Actions环境下上传
if [ "$GITHUB_ACTIONS" = "true" ]; then
    echo "FIRMWARE_PATH=$BUILD_DIR/firmware" >> $GITHUB_ENV
fi

echo "构建成功完成！"
