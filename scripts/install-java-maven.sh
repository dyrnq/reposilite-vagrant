#!/usr/bin/env bash


mkdir -p ~/.local/jvm/21
mkdir -p ~/.local/maven/
mkdir -p ~/.local/bin/


curl -fS#L https://mirrors.tuna.tsinghua.edu.cn/Adoptium/21/jdk/x64/linux/OpenJDK21U-jdk_x64_linux_hotspot_21.0.10_7.tar.gz | tar -xvz --strip-components 1 -C ~/.local/jvm/21
curl -fs#L https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.9.12/binaries/apache-maven-3.9.12-bin.tar.gz |tar -xvz --strip-components 1 -C ~/.local/maven

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