# webpackの開発環境がおかしいとき

## RSpecが落ちるとき
テストモードで再ビルドする
```
RAILS_ENV=test bin/webpack
```

## RAILS_ENV=test bin/webpack  で、エラーになるとき
謎の作業をする
```
# エラー内容
Segmentation fault
error Command failed with exit code 139.

# 対応（理由はわからないけれど、これでうまくいった）
1. キャッシュを消す rm -r node_modules/.cache/*
2. bin/webpack-dev-server を切る
3. yarn を実行する ( yarn install )
4. RAILS_ENV=test bin/webpack を再実行する
```

### Module '"routes"' has no exported member でエラーになるとき
```
bin/code-gen
```

## マージしたあと、うまく動かないとき
キャッシュを消す
```
rm -r node_modules/.cache/*
Dockerの再起動
```


## RSpecがなぜか落ちるとき
```
RAILS_ENV=test bin/rails db:migrate:reset
```

## 開発環境がおかしいとき
### dbがおかしいとき
```
bin/rails db:seeds
```

```
bin/rails db:dump
bin/rails db:migrate:reset
bin/rails db
source tmp/svintage_development_20230209.dump.sql;
```

### モデル名がRailsに乗っていないとき
- config/choron/active_admin/settings.yml
  - namespace を修正する


## RAILS_ENV=production でビルドに失敗しちゃう
これずっと原因わかってないんですが
typeのnode_moduleもdependenciesでいれてください！
devdependenciesだと、RAILS_ENV=production でビルドに失敗しちゃう

```package.json
{
  "dependencies": {
    // ここ！
  },
  "version": "0.1.0",
  "devDependencies": {
    // ここじゃない！
  }

```


## CIが落ちてしまう
.github/workflows/rspec.yml
```yml
# yarn のキャッシュが悪さをしてそうならここの v1 を v2 などにして修正してみてください
key: yarn-v3-${{ hashFiles('**/yarn.lock') }}
```


## bin/code-gen
実態は、
```
bin/rails js:routes:typescript
bundle exec ruby scripts/choron/js_const.rb
```

- app/javascript/routes.js
- app/javascript/routes.d.ts