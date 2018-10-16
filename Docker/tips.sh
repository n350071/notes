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
