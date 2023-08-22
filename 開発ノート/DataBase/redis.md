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

### connect to redis server
```
$ redis-cli -h redis.server.name -p 6379
$ redis-cli -u redis://127.0.0.1:6379/1
```

[Adds the `-u <uri>` option to redis-cli #3409](https://github.com/antirez/redis/pull/3409)

-h -p はホスト名, ポート名指定だけれど、
-u なら、 `config/settings/development.yml` からコピって貼るだけなので便利。

## count keys

```
> DBSIZE
(integer) 7468317
```

```
$ redis-cli -u redis://127.0.0.1:6379/1  KEYS "*" | wc -l
$ redis-cli -u redis://127.0.0.1:6379/1  KEYS "*resque*" | wc -l
```


## redis with Rails ActiveJob

```
class BlahBlahJob < ActiveJob::Base
  queue_as :default

  def perform(arg)
    do_something(arg)
  end
end
```

```
$ job = BlahBlahJob.perform_later @something
Enqueued BlahBlahJob (Job ID: xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxx) to Resque(default) with arguments: gid://application-name/BlahBlah/1

$ job.queue_name
=> "default"
```

```
$ redis-cli -u redis://127.0.0.1:6379/1

> keys "resque:queue:default"
1) "resque:queue:default"

> type "resque:queue:default"
list

> lrange "resque:queue:default" 0 -1
1) "{\"class\":\"ActiveJob::QueueAdapters::ResqueAdapter::JobWrapper\",\"args\":[{\"job_class\":\"BlahBlahJob\",\"job_id\":\"xxxxxxx-xxxx-xxxx-xxxx-xxxxxxxx\",\"queue_name\":\"default\",\"arguments\":[{\"_aj_globalid\":\"gid://application-name/BlahBlah/1\"}],\"locale\":\"ja\"}]}"
```
