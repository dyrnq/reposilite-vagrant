#!/usr/bin/env bash
# cat > hutool-all-5.8.43.pom<<'EOF'
# <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
#          xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
#     <modelVersion>4.0.0</modelVersion>

#     <groupId>cn.hutool</groupId>
#     <artifactId>hutool-all</artifactId>
#     <version>5.8.43</version>
#     <packaging>jar</packaging>

#     <name>hutool-all</name>
#     <description>hutool-all</description>

#     <!-- 添加依赖信息，如果有的话 -->
# </project>
# EOF

# curl -O -f#SL https://repo.maven.apache.org/maven2/cn/hutool/hutool-all/5.8.43/hutool-all-5.8.43.jar
# curl -O -f#SL https://repo.maven.apache.org/maven2/cn/hutool/hutool-all/5.8.43/hutool-all-5.8.43.pom


curl -O -f#SL https://repo.huaweicloud.com/repository/maven/cn/hutool/hutool-all/5.8.43/hutool-all-5.8.43.jar
curl -O -f#SL https://repo.huaweicloud.com/repository/maven/cn/hutool/hutool-all/5.8.43/hutool-all-5.8.43.pom

# https://maven.apache.org/plugins/maven-deploy-plugin/deploy-file-mojo.html

mvn deploy:deploy-file \
-DgroupId=cn.hutool \
-DartifactId=hutool-all \
-Dversion=5.8.43 \
-Dpackaging=jar \
-Dfile=hutool-all-5.8.43.jar \
-DpomFile=hutool-all-5.8.43.pom \
-Durl="http://admin:pass@192.168.111.10:18080/private"

rm -rf ./*.jar
rm -rf ./*.pom