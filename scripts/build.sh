#!/bin/bash

# OpenWrt Build Script for TL-WR842N v3
# 一键编译脚本

set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}开始编译 OpenWrt for TL-WR842N v3...${NC}"

# 检查环境
if ! command -v git &> /dev/null; then
    echo -e "${RED}错误: git 未安装${NC}"
    exit 1
fi

# 克隆OpenWrt源码
if [ ! -d "openwrt" ]; then
    echo -e "${YELLOW}克隆OpenWrt源码...${NC}"
    git clone --depth=1 https://github.com/openwrt/openwrt.git openwrt
    cd openwrt
    git checkout openwrt-22.03
else
    echo -e "${YELLOW}更新OpenWrt源码...${NC}"
    cd openwrt
    git pull
fi

# 更新和安装feeds
echo -e "${YELLOW}更新和安装feeds...${NC}"
./scripts/feeds update -a
./scripts/feeds install -a

# 下载自定义包
echo -e "${YELLOW}下载自定义包...${NC}"
[ -d "package/luci-app-cupsd" ] || git clone https://github.com/project-openwrt/luci-app-cupsd.git package/luci-app-cupsd
[ -d "package/foo2zjs" ] || git clone https://github.com/kanhoo/foo2zjs-openwrt.git package/foo2zjs

# 复制配置文件
echo -e "${YELLOW}复制配置文件...${NC}"
cp ../configs/wr842n-v3.config .config

# 复制自定义文件
echo -e "${YELLOW}复制自定义文件...${NC}"
cp -r ../files/* files/

# 配置构建
echo -e "${YELLOW}配置构建...${NC}"
make defconfig

# 下载dl库
echo -e "${YELLOW}下载dl库...${NC}"
make download -j8

# 开始编译
echo -e "${GREEN}开始编译固件...${NC}"
make -j$(nproc) V=s

# 复制固件文件
echo -e "${YELLOW}复制固件文件...${NC}"
mkdir -p ../firmware
cp bin/targets/ar71xx/generic/*.bin ../firmware/

echo -e "${GREEN}编译完成！固件文件在 firmware/ 目录${NC}"
echo -e "${GREEN}固件文件名: $(ls ../firmware/*.bin)${NC}"
