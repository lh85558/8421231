# 本地构建指南

## 环境要求
- Ubuntu 22.04 LTS 或更高版本
- 至少 4GB 内存
- 20GB 可用磁盘空间
- 稳定的网络连接

## 快速开始

### 方法1: 使用Docker构建（推荐）
```bash
# 构建Docker镜像
docker-compose build

# 开始构建
docker-compose up
```

### 方法2: 本地直接构建
```bash
# 给脚本添加执行权限
chmod +x quick-build.sh

# 运行构建脚本
./quick-build.sh
```

### 方法3: 手动构建
```bash
# 安装依赖
sudo apt-get update
sudo apt-get install -y build-essential ccache ecj fastjar file g++ gawk \
    gettext git java-propose-classpath libelf-dev libncurses5-dev \
    libncursesw5-dev libssl-dev python python2.7-dev python3 unzip wget \
    python3-distutils python3-setuptools python3-dev rsync subversion \
    swig time xsltproc zlib1g-dev

# 运行详细构建脚本
./scripts/build.sh
```

## 构建输出
构建完成后，固件文件将保存在 `firmware/` 目录中：
- `openwrt-ar71xx-generic-tl-wr842n-v3-squashfs-factory.bin` - 原厂固件
- `openwrt-ar71xx-generic-tl-wr842n-v3-squashfs-sysupgrade.bin` - 升级固件

## 固件特点
- 集成CUPS中文打印服务
- 预装HP LaserJet系列打印机驱动
- USB打印机支持
- 定时重启功能
- 中文Web界面
- 优化16M闪存使用

## 默认配置
- 管理地址: http://192.168.10.1
- 用户名: admin
- 密码: thdn12345678
- WiFi名称: THDN-dayin
- WiFi密码: thdn12345678

## 故障排除
1. 如果构建失败，检查网络连接和磁盘空间
2. 清理构建缓存: `make clean` 或 `make dirclean`
3. 查看详细日志: 在构建命令后添加 `V=s`

## 注意事项
- 首次刷机请使用factory.bin
- 升级请使用sysupgrade.bin
- 刷机有风险，请谨慎操作
- 建议备份原厂固件
