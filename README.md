# Windward Horizon Game Server

_Based on the original docker image [gameservers/windward](https://hub.docker.com/r/gameservers/windward/)_

See more about Windward Horizon at: [https://store.steampowered.com/app/2665460/Windward_Horizon/](https://store.steampowered.com/app/2665460/Windward_Horizon/)

You can use the following environment variables passed to the Docker container to configure your server.

* WINDWARD_SERVER_NAME - The name of the server.
* WINDWARD_SERVER_WORLD - The name of the world to create on the server.
* WINDWARD_SERVER_PORT - The port number to use for the server (Note - This will require you exposing other ports within your container)
* WINDWARD_SERVER_PUBLIC - 1 = public, anything else will make this server private (default: 0).
* WINDWARD_SERVER_ADMIN - Steam ID of the server admin (Currently only supports a single server admin).

Example docker run:
```
docker run --name "Windward-Horizon-Server"        \
  -e WINDWARD_SERVER_NAME="My Server"      \
  -e WINDWARD_SERVER_WORLD="world"         \
  -e WINDWARD_SERVER_ADMIN=123456787453234 \
  -v ~/WindwardServer:/data/windward       \
  -p 5123:5123                             \
  gregjoeval/windward-horizon:latest
```
