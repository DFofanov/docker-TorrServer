# TorrServer
Unofficial Docker Image for TorrServer

## Usage
```sh
docker run -d \
    -p 8090:8090 \
    -v config:/torrserver/config \
    -e TZ=Europe/Moscow \
    --restart always \
    --name torrserver \    
    19780529/torrserver
```

## Parameters
* ```-p 8090:8090``` - TorrServer port
* ```-v config:/torrserver/config``` - where TorrServer store config files
* ```-e TZ=Europe/Moscow``` - Time Zone
* ```--name torrserver``` - container name

## Info
* To monitor the logs of container in realtime ```docker logs torrserver```

## Versions
* 09.11.2021: TorrServer ver. 1.1.77