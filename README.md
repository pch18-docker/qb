![](https://images.microbadger.com/badges/version/gists/qbittorrent.svg) ![](https://images.microbadger.com/badges/image/gists/qbittorrent.svg) ![](https://img.shields.io/docker/stars/gists/qbittorrent.svg) ![](https://img.shields.io/docker/pulls/gists/qbittorrent.svg)

#### Environment:

| Environment | Default value |
|-------------|---------------|
| UID       | 1000            |
| GID       | 1000            |

##### username & password

- username: admin
- password: adminadmin

#### Volume

- /data

#### Creating an instance:

    docker run \
        -d \
        --name qbittorrent \
        -p 58023:58023 \
        -p 58023:58023/udp \
        -p 8999:8999 \
        -v /path/data:/data
        gists/qbittorrent

#### Compose example:

    qbittorrent:
        image: gists/qbittorrent
        ports:
            - "8999:8999"
            - "58023:58023"
            - "58023:58023/udp"
        volumes:
            - /path/data:/data
        environment:
            - UID=1000
            - GID=1000
      restart: always
