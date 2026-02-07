#!/usr/bin/env bash


mkdir -p ~/.local/jvm/21
mkdir -p ~/.local/maven/
mkdir -p ~/.local/bin/

jdk_url="https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.9%2B10/OpenJDK21U-jdk_x64_linux_hotspot_21.0.9_10.tar.gz"
mvn_url="https://archive.apache.org/dist/maven/maven-3/3.9.12/binaries/apache-maven-3.9.12-bin.tar.gz"


# jdk_url="https://mirrors.tuna.tsinghua.edu.cn/Adoptium/21/jdk/x64/linux/OpenJDK21U-jdk_x64_linux_hotspot_21.0.10_7.tar.gz"
# mvn_url="https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.9.12/binaries/apache-maven-3.9.12-bin.tar.gz"

jdk_url="https://mirrors.ustc.edu.cn/adoptium/releases/temurin21-binaries/jdk-21.0.9%2B10/OpenJDK21U-jdk_x64_linux_hotspot_21.0.9_10.tar.gz"
mvn_url="https://mirrors.ustc.edu.cn/apache/maven/maven-3/3.9.12/binaries/apache-maven-3.9.12-bin.tar.gz"

curl -fS#L "${jdk_url}" | tar -xvz --strip-components 1 -C ~/.local/jvm/21
curl -fs#L "${mvn_url}" | tar -xvz --strip-components 1 -C ~/.local/maven

if ! cat ~/.bashrc |grep JAVA_HOME; then
    echo "JAVA_HOME=\$HOME/.local/jvm/21" >> ~/.bashrc
    echo "PATH=\$JAVA_HOME/bin:\$PATH" >> ~/.bashrc
fi

if ! cat ~/.bashrc |grep MAVEN_HOME; then
    echo "MAVEN_HOME=\$HOME/.local/maven" >> ~/.bashrc
    echo "PATH=\$MAVEN_HOME/bin:\$PATH" >> ~/.bashrc
fi

cat ~/.bashrc


java --version
mvn --version