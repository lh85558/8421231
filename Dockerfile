FROM ubuntu:22.04

# 设置环境变量
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    ccache \
    ecj \
    fastjar \
    file \
    g++ \
    gawk \
    gettext \
    git \
    java-propose-classpath \
    libelf-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libssl-dev \
    python \
    python2.7-dev \
    python3 \
    python3-distutils \
    python3-setuptools \
    python3-dev \
    rsync \
    subversion \
    swig \
    time \
    xsltproc \
    zlib1g-dev \
    wget \
    unzip \
    curl \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# 创建工作目录
WORKDIR /workspace

# 复制项目文件
COPY . /workspace/

# 设置权限
RUN chmod +x /workspace/scripts/build.sh

# 设置默认命令
CMD ["/bin/bash"]
