# Use runtime as the base image
FROM kasmweb/core-ubuntu-jammy:1.17.0-rolling-daily

# Install FFmpeg and Chinese fonts
RUN apt-get update && \
    apt-get install -y \
    wget \
    gnupg \
    ca-certificates \
    curl \
    unzip \
    fontconfig \
    fonts-noto-cjk-extra \
    ttf-wqy-microhei \
    locales \
    jq \
    tar \
    openjdk-17-jdk \
    && apt-get update \
    && apt-get install -y ffmpeg \
    # install fingerprint
    && wget https://github.com/adryfish/fingerprint-chromium/releases/download/135.0.7049.95/ungoogled-chromium_135.0.7049.95-1_linux.tar.xz \
    && tar -xJf ungoogled-chromium_135.0.7049.95-1_linux.tar.xz \
    && rm -f ./ungoogled-chromium_135.0.7049.95-1_linux.tar.xz \
    # 中文环境配置
    && sed -i 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen \
    && fc-cache -fv \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/*

# 设置中文环境变量
ENV LANG=zh_CN.UTF-8
ENV LC_ALL=zh_CN.UTF-8

# Set the working directory
WORKDIR /app

# Default command
CMD ["bash"]
