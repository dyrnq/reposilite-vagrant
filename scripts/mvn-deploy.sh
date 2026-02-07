#!/usr/bin/env bash


pushd demo-application || exit 1
    mvn -gs ../settings.xml clean package deploy
popd || exit 1