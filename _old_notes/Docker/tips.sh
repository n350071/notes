# delete all no tag images
docker rmi $(docker images | grep '<none>' | awk '{print$3}')

### デバッガー（ブレークポイント）を使う場合
`docker-compose up` ではデバッガー（ブレークポイント）を使うことが出来ないので、
`binding.pry` や `beybug` を使いたい場合は次のようにする。

```
$ docker-compose run --service-ports web bundle exec rails s -b 0.0.0.0
```

```
docker-compose run db bash
psql -h db -U postgres -d xxxxx_development
```

Stop all run container
```
docker stop $(docker ps -aq)
```

https://qiita.com/c18t/items/f3a911ef01f124071c95
```
RUN echo 'Hello, ' && \
    : "何もしないコマンドをコメントとして利用" && \
    echo 'world!'
```

# ベストプラクティス

## RUN
# - cache busting
# - sort order
# - rm
```
RUN apt-get update && apt-get install -y \
    aufs-tools \
    automake \
    build-essential \
    curl \
    dpkg-sig \
    libcap-dev \
    libsqlite3-dev \
    mercurial \
    reprepro \
    ruby1.9.1 \
    ruby1.9.1-dev \
    s3cmd=1.1.* \
 && rm -rf /var/lib/apt/lists/*
```

## ADD & COPY
```
ADD http://example.com/big.tar.xz /usr/src/things/
RUN tar -xJf /usr/src/things/big.tar.xz -C /usr/src/things
RUN make -C /usr/src/things all
And instead, do something like:
```
instead of
```
RUN mkdir -p /usr/src/things \
    && curl -SL http://example.com/big.tar.xz \
    | tar -xJC /usr/src/things \
    && make -C /usr/src/things all
```
