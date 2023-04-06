# [autoload_paths](https://railsguides.jp/autoloading_and_reloading_constants.html#autoload-paths)

Railsにはpost.rbのようなファイルを探索する$LOAD_PATHに似た、ディレクトリのコレクションがあります。このコレクションはautoload_pathsと呼ばれており、デフォルトで以下が含まれます。

アプリケーションとエンジンのappディレクトリ以下にあるすべてのサブディレクトリ。app/controllersなどが対象。app以下に置かれるapp/workersなどのカスタムディレクトリはすべてautoload_pathsに自動的に属するので、デフォルトのディレクトリとする必要はない。

アプリケーションとエンジンのすべての `app/*/concerns` 第2サブディレクトリ。

test/mailers/previewsディレクトリ。

このコレクションは `config.autoload_paths` で設定できます。たとえばlibディレクトリは以前はコレクションに含まれていましたが、現在は含まれていません。必要であれば、config/application.rbにあえて以下のコードを追加して (オプトイン)、libディレクトリをautoload_pathsに追加することもできます。


## autoload_paths の確認方法
```
bundle exec rails r 'puts ActiveSupport::Dependencies.autoload_paths'
```
