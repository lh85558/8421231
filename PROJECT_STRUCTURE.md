# 项目结构说明

```
openwrt-tl-wr842n-v3/
├── .github/
│   └── workflows/
│       └── build-openwrt.yml          # GitHub Actions 自动构建工作流
├── configs/
│   └── wr842n-v3.config               # OpenWrt 配置文件
├── files/
│   ├── etc/
│   │   ├── config/
│   │   │   ├── cupsd                  # CUPS 配置
│   │   │   ├── firewall               # 防火墙配置
│   │   │   ├── network                # 网络配置
│   │   │   ├── system                 # 系统配置
│   │   │   └── wireless               # 无线配置
│   │   ├── crontabs/
│   │   │   └── root                   # 定时任务
│   │   └── init.d/
│   │       └── cups-setup             # CUPS 初始化脚本
├── scripts/
│   └── build.sh                       # 详细构建脚本
├── Dockerfile                         # Docker 构建环境
├── docker-compose.yml                 # Docker Compose 配置
├── quick-build.sh                     # 快速构建脚本
├── README.md                          # 项目说明
├── LOCAL_BUILD.md                     # 本地构建指南
└── PROJECT_STRUCTURE.md               # 项目结构说明
```

## 主要文件说明

### 配置文件
- `configs/wr842n-v3.config`: OpenWrt 构建配置，包含所有软件包选择
- `files/etc/config/*`: 系统配置文件，定义默认网络、WiFi、防火墙等设置

### 构建脚本
- `quick-build.sh`: 一键快速构建脚本
- `scripts/build.sh`: 详细构建脚本，包含完整步骤
- `.github/workflows/build-openwrt.yml`: GitHub Actions 自动构建配置

### 自定义文件
- `files/etc/init.d/cups-setup`: CUPS 服务初始化脚本
- `files/etc/crontabs/root`: 定时重启任务配置

### Docker 支持
- `Dockerfile`: Ubuntu 22.04 构建环境
- `docker-compose.yml`: Docker Compose 配置，简化构建过程

## 使用流程
1. 配置文件已预设所有必需选项
2. 运行构建脚本自动生成固件
3. GitHub Actions 支持自动云编译
4. 输出文件直接为可用的 bin 固件
