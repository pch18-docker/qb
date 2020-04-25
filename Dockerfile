FROM alpine:3.11

ARG QBITTORRENT_VER=4.2.3
ARG LIBTORRENT_VER=1.2.5

LABEL maintainer="pch18"

ENV UID=1000 \
    GID=1000 \
    WEBUI_PORT=8999

RUN set -ex && \
    apk add --no-cache su-exec && \
    apk add --no-cache --virtual .build-deps \
        boost-dev \
        boost-system \
        boost-thread \
        ca-certificates \
        curl \
        g++ \
        libressl-dev \
        make \
        qt5-qtbase \
        qt5-qttools-dev \
        tar && \
    mkdir -p /tmp/libtorrent-rasterbar /tmp/qbittorrent && \
    cd /tmp/libtorrent-rasterbar/ && \
    curl -sSL https://github.com/arvidn/libtorrent/releases/download/libtorrent-${LIBTORRENT_VER//./_}/libtorrent-rasterbar-$LIBTORRENT_VER.tar.gz | tar xz --strip 1 && \
    ./configure --prefix=/usr && \
    make install-strip && \
    cd /tmp/qbittorrent && \
    curl -sSL https://github.com/qbittorrent/qBittorrent/archive/release-$QBITTORRENT_VER.tar.gz | tar xz --strip 1 && \
    ./configure --prefix=/usr --disable-gui --disable-stacktrace && \
    make install && \
    cd / && \
    runDeps="$( \
        scanelf --needed --nobanner /usr/lib/libtorrent-* /usr/bin/qbittorrent* \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | xargs -r apk info --installed \
            | sort -u \
    )" && \
    apk add --no-cache --virtual .run-deps $runDeps && \
    apk del .build-deps && \
    rm -rf /tmp/*

COPY rootfs /

VOLUME [ "/data" ]

EXPOSE 58023 58023/udp 8999

ENTRYPOINT ["/usr/bin/entrypoint.sh"]



