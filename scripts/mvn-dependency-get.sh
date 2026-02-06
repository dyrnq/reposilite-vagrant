#!/usr/bin/env bash

mvn -gs settings.xml \
dependency:get \
-U \
-DgroupId=cn.hutool \
-DartifactId=hutool-all \
-Dversion=5.8.43
