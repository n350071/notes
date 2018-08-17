# 他言語習得済みの人が Ruby on Rails で開発する前に読んでおいた方がよさげなURL一覧
forked from https://gist.github.com/redmount/20b74f1c895ef407311fed05767adf84

チームに新しくジョインしてくれた方から聞かれたので、自分用にもまとめておく。

## Ruby 周りの見ておいた方が良いURL
Ruby はオブジェクト指向言語なので、恐らく Java とか Python とかやってた人は割とすんなり入れると思う。ただ、PHPの人は戻り値周りとモジュール、 Mix-in あたりで最初躓くかもしれない。あと JavaScript (≠ ECMA, TypeScript) な人も、変数の扱いとかで微妙に躓くと思われる。

* [他言語からのRuby入門](https://www.ruby-lang.org/ja/documentation/ruby-from-other-languages/)
* [Ruby 2.4.0 リファレンスマニュアル](https://docs.ruby-lang.org/ja/2.4.0/doc/index.html) <- 言語仕様、組み込みライブラリ、標準添付ライブラリ あたりはざっくり目を通しておくと良い
* [Ruby 2.1.0リリース！注目の新機能を見てみましょう](https://techracho.bpsinc.jp/baba/2013_12_26/15026)
* [Ruby2.2の変更点と新機能の紹介](https://allabout.co.jp/gm/gc/452102/)
* [サンプルコードでわかる！Ruby 2.3の主な新機能 - Qiita](http://qiita.com/jnchito/items/0faac073cb77417d61c7)
* [サンプルコードでわかる！Ruby 2.4の新機能と変更点 - Qiita](http://qiita.com/jnchito/items/9f9d45581816f121af07)

オライリーから出ているRubyの本に限らず、Rubyの本は若干古めのものが多いので、バージョン違いによる新機能はさらっと見ておくと幸せになれると思う。

##  Rails 周りの見ておいた方が良いURL
Rails はなんだかんだ枯れてきているので、一通りチュートリアル読めば使えるようになると思う。むしろ鬼門は Rubygems の何を組み合わせて作るか、だったりする。 Rubygems を知っている量で Rails 開発の速度は驚くほど変わるし、車輪の再開発を免れるのでテストを書いたりする量もだいぶ減る。

* [Rails 5: The Tour - YouTube](https://www.youtube.com/watch?v=OaDhY_y8WTo&feature=youtu.be) <- 英語だけど、本家の動画で30分かからないのでざっくり見るとなんとなくやることがわかって良いと思う
* [Getting Started with Rails](http://guides.rubyonrails.org/getting_started.html) <- 一通り Rails の設計思想とかを、実際にコードを書きながら学べるのでオススメ。ただし英語
* [Ruby on Rails チュートリアル：実例を使って Rails を学ぼう](https://railstutorial.jp/) <- 上記の日本語版のようなもの。英語だとわかりにくい部分の補足用にオススメ
* [Ruby on Rails Guides (v5.0.2)](http://guides.rubyonrails.org/) <- 余裕があれば
* [Ruby on Rails 5.0.2 RDoc](http://api.rubyonrails.org/) <- さらに余裕があれば ActiveSupport, ActiveModel あたりのメソッドを一通り見ておくと良い

### 参考: よく使う Gem とか

Rails の Gem は用途次第で何を使うか決めた方が良いと思うので、あくまでも参考程度に。
[Ruby on Rails 初心者に贈る絶対に使いたくなるGem15選｜ferret フェレット](https://ferret-plus.com/4883) あたりも見ると良いかもしれない。

#### 認証系
認証系の王道ですが、若干学習コストが高めなので、本当にここまでのものが必要なのかは検討した方が良いかと。ただし、後から入れることを検討しているのであれば最初から入れた方が楽。

* [GitHub - plataformatec/devise: Flexible authentication solution for Rails with Warden.](https://github.com/plataformatec/devise)
* [GitHub - scambra/devise_invitable: An invitation strategy for devise](https://github.com/scambra/devise_invitable)
* [GitHub - CanCanCommunity/cancancan: The authorization Gem for Ruby on Rails.](https://github.com/CanCanCommunity/cancancan)

#### テスト系
RSpec 派はとりあえず入れておけば良いと思う。

* [GitHub - rspec/rspec-rails: RSpec for Rails-3+](https://github.com/rspec/rspec-rails)
* [GitHub - thoughtbot/factory_girl_rails: Factory Girl ♥ Rails](https://github.com/thoughtbot/factory_girl_rails)
* [GitHub - colszowka/simplecov: Code coverage for Ruby 1.9+ with a powerful configuration library and automatic merging of coverage across test suites](https://github.com/colszowka/simplecov)
* [GitHub - stevenosloan/slack-notifier: A simple wrapper for posting to slack channels](https://github.com/stevenosloan/slack-notifier)

#### View周りの作成に役立つ系
Kaminari はもはやページングのデファクトスタンダードです。デザイナーさんのこだわりによってはなかなかエグいページングのデザインを渡される事があるので Kaminari でそこまで工数をかけずにできる範囲は知っておいた方が良いです。（エグいやつもできなくはないけど割と大変だと思います）

* [GitHub - kaminari/kaminari: ⚡ A Scope & Engine based, clean, powerful, customizable and sophisticated paginator for Ruby webapps](https://github.com/kaminari/kaminari)
* [GitHub - twbs/bootstrap-sass: Official Sass port of Bootstrap 2 and 3.](https://github.com/twbs/bootstrap-sass)
* [GitHub - slim-template/slim-rails: Slim templates generator for Rails 3, 4 and 5](https://github.com/slim-template/slim-rails)

#### メール送ったりするなら入れておきたい系
HTMLメール送ったりするのをイチイチSMTPサーバー噛ませて、ってするのはとても面倒なので入れておくと良い。ほとんどのRailsアプリではメール送るタイミングが発生すると思うので是非。

* [GitHub - fphilipe/premailer-rails: CSS styled emails without the hassle.](https://github.com/fphilipe/premailer-rails)
* [GitHub - ryanb/letter_opener: Preview mail in the browser instead of sending.](https://github.com/ryanb/letter_opener)

#### ファイルアップロードするなら入れておきたい系
ファイルアップロードは paperclip 含めていくつかあるけれど、恐らく一番簡単なのは paperclip だと思われる。ただし、これも用途次第なので、合わないなと思ったら別の Gem も検討した方が良い。

* [GitHub - thoughtbot/paperclip: Easy file attachment management for ActiveRecord](https://github.com/thoughtbot/paperclip)

#### Excel の呪縛から逃れられない系
 Excelの呪縛から逃れられない時のために。 Hashie は Excel 関係なくインストールしておくと割と便利。

* [GitHub - zdavatz/spreadsheet: The Ruby Spreadsheet by ywesee GmbH](https://github.com/zdavatz/spreadsheet)
* [GitHub - roo-rb/roo: Roo provides an interface to spreadsheets of several sorts.](https://github.com/roo-rb/roo)
* [GitHub - intridea/hashie: Hashie is a collection of classes and mixins that make hashes more powerful.](https://github.com/intridea/hashie)

#### AWS使ったり、変更ログ取るなら入れておきたい系
* [GitHub - aws/aws-sdk-ruby: The official AWS SDK for Ruby.](https://github.com/aws/aws-sdk-ruby)
* [GitHub - airblade/paper_trail: Track changes to your models’ data.  Good for auditing or versioning.](https://github.com/airblade/paper_trail)

#### その他
デフォルトでインストールされるけれど Turbolinks は割と Rails でハマる人が多いので読んでおくと幸せになれると思います。

* [GitHub - turbolinks/turbolinks: Turbolinks makes navigating your web application faster](https://github.com/turbolinks/turbolinks)
