
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
        -p 58999:58999 \
        -v /path/data:/data \
        pch18/qb

#### Compose example:

    qbittorrent:
        image: pch18/qb
        ports:
            - "58999:58999"
            - "58023:58023"
            - "58023:58023/udp"
        volumes:
            - /path/data:/data
        environment:
            - UID=1000
            - GID=1000
      restart: always
