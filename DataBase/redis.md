# redis

## what is redis?
in-memory data structure store, used as a database, cache and message broker. It supports data structures such as strings, hashes, lists, sets, sorted sets with range queries, bitmaps, hyperloglogs and geospatial indexes with radius queries.

## tutorial and commands
- http://try.redis.io/
- https://qiita.com/rubytomato@github/items/d66d932959d596876ab5#keys

## install

```
$ brew install redis
$ brew -l | grep redis
redis
```

## redis-cli

```
$ ssh -i ~/.ssh/server.pem server-user@xxx.xxx.xxx.xxx
$ redis-cli -h redis.server.name -p 6379
```
