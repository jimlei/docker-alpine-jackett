### Build/Rebuild and Run

```
docker stop jackett ; docker rm jackett ; docker rmi jackett \
    ; docker build -t jackett /docker/docker-jackett \
    && docker run -d --name jackett -v /config/jackett:/config -p 9117:9117 jackett
```

Go to http://localhost:9117

Configuration in the container is located at /config

The run command maps /config/jackett in the host to the container config directory (so when rebuilding, you can keep you config)
