# OpenWrt 固件编译项目 - TP-Link TL-WR842N v3

## 项目简介
为TP-Link TL-WR842N v3 (AR9531)路由器编译集成CUPS中文打印服务的OpenWrt稳定版固件。

## 主要功能
- 集成CUPS中文打印服务
- 预装HP LaserJet 1020/1020plus/1007/1008/1108打印机驱动
- USB打印机支持
- 定时重启功能
- 中文Web界面

## 默认配置
- LAN IP: 192.168.10.1
- Web登录: admin / thdn12345678
- Wi-Fi SSID: THDN-dayin
- Wi-Fi密码: thdn12345678
- 主机名: THDN-PrintServer

## 构建环境
- Ubuntu 22.04 LTS
- OpenWrt 22.03+ 稳定版
- GitHub Actions 云编译

## 使用方法
1. Fork此仓库
2. 在GitHub Actions中触发构建
3. 下载生成的固件文件

## 固件特点
- 16M闪存优化
- 非交互式配置
- 直接输出bin固件
- 全部依赖升级至最新稳定版
