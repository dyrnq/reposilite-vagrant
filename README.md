# reposilite-vagrant


## intro

reposilite usage showcase.


## mirrors

```xml
  <mirrors>
    <mirror>
        <id>central-mirror</id>
        <mirrorOf>central</mirrorOf>
        <name>阿里云公共仓库</name>
        <url>https://maven.aliyun.com/repository/public</url>
    </mirror>
  </mirrors>
```

```xml
  <mirrors>
    <mirror>
        <id>central-mirror</id>
        <mirrorOf>central</mirrorOf>
        <url>https://repo.huaweicloud.com/repository/maven/</url>
    </mirror>
  </mirrors>
```

```xml
  <mirrors>
    <mirror>
        <id>central-mirror</id>
        <mirrorOf>central</mirrorOf>
        <name>Nexus tencentyun</name>
        <url>http://mirrors.cloud.tencent.com/nexus/repository/maven-public/</url>
    </mirror>
  </mirrors>
```


## ref

- <https://hub.docker.com/r/dzikoysk/reposilite>
- <https://reposilite.com/guide/docker>

