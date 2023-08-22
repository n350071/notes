# every time I forget this..
## bundle install
### to project
```
bundle install --path vendor/bundle
```

### in docker (install to docker root directory)
```
docker-compose build
docker-compose run web bundle install
```

## enumerize
enumerize :attribute , in: ['to be', 'not to be', 'it is the question'], default: 'to be'
