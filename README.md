### Build/Rebuild and Run

```
docker stop jackett ; docker rm jackett ; docker rmi jackett \
    ; docker build -t jackett /docker/docker-jackett \
    && docker run -d --name jackett -v /config/jackett:/data/config -p 9117:9117 jackett
```

Go to http://localhost:9117

Configuration in the container is located at /data/config

The run command maps /config/jackett in the host to the container /data/config directory (so when rebuilding, you can keep your config)
