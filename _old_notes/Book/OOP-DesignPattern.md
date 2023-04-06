# Essence of OOP

***
## Keep in mind : Cost performance
* Wait until you get enough info to solve it.
  * You Ain't Gonna Need It!
  * You might solve it with misunderstanding!
* 抽象化は大事だが、完璧を求めない
* テストを書いて、バグの修正、文書作成、設計作業にかかる時間を短縮する

## First step : Keep it simple, stupid!
* Take away a role from the thing that has different role.
  * Every single role is the pair of Single Responsibility.
  * Define single role at A place, DRY.
* Encapsulation
  * Wrap and Hide complexity knowledge of the role into a method.

## Second step : Abstraction
* Program to an Interface, Not an Implementation
  * 抽象は安定している -> 特定の事象から離れているから、特定の事象の変化の影響を受けない
  * 変化しすい部分(具象)を安定した部分(抽象)から分離する
  * 抽象は、コンテキスト(特定のなにか)を低下させる・分離する
  * 依存オブジェクト注入
  * 依存性逆転
* Message that tells WHAT(Black box) instead HOW(White box) for 'The Receiver' is a pair of Abstract Interface for 'Receivers'
  * [LOD](#LOD) violation means 'the chain message say HOW', so it's the hint to find a missing 'WHAT' message.
* One Message, Many Behaves -> *Polymorphism*
  * *Polymorphism*
    * Open(for Extending) Closed(for Modification)
    * [LSP](#LSP)(Liskov substitution Principle)
    * Composition over Inheritance

Relationship | Name |  What is special?
--- | --- | ---
is-a | Inheritance | Share the logic with Parent through auto delegation
behave-like-a | DuckType | Define each logic of Role through Interface
behave-like-a | Role(module) | Use the shared logic of Role through Interface
has-a | Composition | Combine objects into a object through Interface

  * Abstraction, Less Context, Less Dependency

Context | 受信者 | メッセージ | 例
--------- | ---------- | -----------
 High | 特定クラスのオブジェクト | 特定の手続きを意図したメッセージ(private) | Mechanic.clean_bicycle(bicycle) and.. check_tires(bicycle) and..
 Middle | 特定クラスのオブジェクト | 特定のなにかを実行することを意図したメッセージ(public) | Mechanic.prepare_bicycle(bicycle)
 Low | 特定のメッセージ受信可能なオブジェクト | 特定のなにかを実行することを意図したメッセージ(public) | object.prepare_bicycle(bicycle)
 No | 信頼されたオブジェクト | 実行内容には踏み込まずに欲しい結果だけを示すメッセージ(public) | object.prepare_trip(self)

***

# Techniques

## Hook methods
* Hook methods permit the concrete classes to choose
  * to accept the default implementation
  * to override the base implementation
    * but, not break default implementation!

## method_missing
* Abstraction of method name, Less Context of method name, Less Dependency of method name

***

# Patterns
## Template Method Pattern
* Inheritance
  * Share almost logic through auto delegation, override details

## Strategy Pattern
* kind of Composition
  * Share only the synonym of Interface, define each logic, and switch them
  * Put a strategy object into the Context through 'operation()' Interface, it can be switched.

## Observer Pattern
* Composition and Iterator for call at once
  * Combine observer objects into the Subject through 'update(self)' Interface

## Composite Pattern
* Composition
  * Combine Leaf objects into Composite(branch) objects, and  (Recursively or Omit) Combine Composite objects into Composite object,  through 'operation()' Interface

## Iterator Pattern
* Encapsulate the process to access the elements of an aggregate object sequentially

## Commands Pattern
* SRP and Encapsulation
  * Multiply ,Take away an action processing role from the action execution part role, and Encapsulate the process of actions with same interface
* Composition and Iterator for call at once
  * Combine action objects into the command queue object through 'execute()' interface (and 'description()')
* Hint
  * it might be okay to implement 'undo()'
    * be carful for the iterator index

## Adapter Pattern
* Encapsulate the process of the Interface conversion from Target Interface to Adaptee Interface into the Adapter method that  receives Target Message.

## Proxy Pattern
* Encapsulate the process of 'something' into the Proxy method that  receives RealService Message.
  * 'something' =
  1. 'protection' : add a check at the start of each method
  1. 'remote procedure call'
  1. 'RealService object creation' : add a process to put into the object or to create the object at the start of each method
* Abstraction, Less Context, Less Dependency
  * Using method_missing makes less context of 'method' name, so 'method_missing proxy' can receive any messages.

## Decorator
* kind of Composition and Inheritance
  * Put a ConcreteComponent(Leaf) into the Decorator object, and Recursively(or Omit) put Decorator object into another Decorator object, and so on, through 'operation()' Interface.
  * The Composed Object can receive new message of the Decorator's new method. Because, always, Children are outside of their Parent.

## Singleton
* DRY : Create a single object in the application
  * Eager instantiation : it's created before called
    * using Class variables and Class method and deny to creation from outside of the class
    * using Class as a container : it must be only one instance
      * every interface has prefix 'self.'
  * Lazy instantiation : it's created after called  
    * include the 'Singleton' module
    * define a module as a container : it must be NO instance

## Factory Method
* SRP
  * Take away the decision which class to instantiate to A Method which implement the Interface from the object that does other work.
* Inheritance
  * share the other work logics with Creator, define only which class to instantiate in ConcreteFactory
* Duck
  * Product should behave like a Product

## Abstract Factory
* SRP
  * Take away the objects creation responsibility from Client object
* Composition
  * Client object has a Concrete factory object which create related Products
* Dependency Injection to Factory method
  * Client object that has factory method is dependent to its sub class, because when it calls its factory method it refer sub class implementation, then inject a abstract factory object to the client object so that the client object can call any method that implemented the interface.


## Builder
* Encapsulation
* Polymorphism

## Interpreter

***

## Visitor
* SRP and Open-Closed
  * the visitor design pattern is a way of separating an algorithm from an object structure on which it operates. A practical result of this separation is the ability to add new operations to existent object structures without modifying the structures. It is one way to follow the open/closed principle.

***

# 以下、途中経過のメモ

***
### パブリックメッセージ
* パブリック/プライベートを明示的に書き分ける(:nodoc:など)
* 実装するのは受け手だが、考える順序は、送り手が出したいメッセージを見る。
* なるべく、送り手が求めている結果は何か？だけをメッセージで伝えるようにする
* シーケンス図を使うと、メッセージに集中できる
  * ツールなので、使い終わったら消すこと
  * オブジェクト間にメッセージの絨毯ができてはいけない。橋程度におさえる
* 重要な問い
  * 「メッセージの受け手は、どのオブジェクトの責任であるべきか？」
  * 「メッセージを送る必要があるけど、誰が応答するべきか？」
  * 「どのように？と細かく指図していないか(private)？」
  * 「なにを？とメニューを頼むように端的にメッセージを送れているか(public)？」
* メッセージを基本とするアプリケーションを作る
  * メッセージを使ってオブジェクトを見つける
  * オブジェクトが存在するからメッセージを送るのではない、メッセージを送るために受信するオブジェクトが存在するのだ!!

#### メッセージチェーンとLow Of Demeter、依存
* 直接の友達とだけ話すこと(友達を「経由して」向こうの友達と話すのは違反)
  * オブジェクトは、お互いの内部についての知識を最小にするべき
  * `objectA.get_objectB.get_objectC.do_smth`は、AがBについて、Bのパブリックインタフェース(`get_objectC`)以上を知っていることを要求するので、違反。BがCを取得できるという知識はBが知っていることであって、Aが知ることではない。
    1. 参照を持つ `objectA.get_objectC.do_smth`
    1. ラッパーメソッドにする `objectA.get_objectB.do_smth_ofC`
* プログラマが、オブジェクトの連鎖を知っていて、それをコードに落とすとき、「どのように実現するか」という具体的な知識を埋め込むことになる。(抽象へ依存せよ)。メッセージ基づき「何を実現するか？」という視点でメソッドを書き直せ。
* チェーン = パブリックインタフェースが欠けていることのヒント

#### コンテキストとメッセージと依存 → ダックタイピング
* あるオブジェクトが責務を果たすために必要となる最小の情報量
* 送り手は求めている結果だけが欲しい
* 受け手は自身が何をしているかまで知られなくていい
* Who > How > What の順にコンテキストと依存が下がる

##### 例：tripオブジェクトが旅の準備をする責務を果たしたいときのコンテキスト

Context | 受信者 | メッセージ | 例
--------- | ---------- | -----------
 High | 特定クラスのオブジェクト | 特定の手続きを意図したメッセージ(private) | Mechanic.clean_bicycle(bicycle) and.. check_tires(bicycle) and..
 Middle | 特定クラスのオブジェクト | 特定のなにかを実行することを意図したメッセージ(public) | Mechanic.prepare_bicycle(bicycle)
 Low | 特定のメッセージ受信可能なオブジェクト | 特定のなにかを実行することを意図したメッセージ(public) | object.prepare_bicycle(bicycle)
 No | 信頼されたオブジェクト | 実行内容には踏み込まずに欲しい結果だけを示すメッセージ(public) | object.prepare_trip(self)

### 依存を管理する(CBO:Coupling Between Objects)

* **依存をメソッドで包み隠す** (Encapsulation)
* **依存オブジェクトを注入する** (Dependency Injection)
* **自身より変更されないものに依存しなさい**
  * コンクリート(具象)ではなく、抽象に依存せよ
  * さらに、なるべく言語機能やフレームワークなど、より安定したものに依存を集中させる

#### 外部クラスへの依存の除去(Dependency Injection)
* クラス名への依存は再利用性を下げ、依存先の影響を受ける作りにするため、
* メッセージに応答するオブジェクトを持たせる(依存オブジェクト注入:Dependency Injection)
* 依存するものを常に気に留め、それらに依存オブジェクトを注入することを習慣化すること。

##### クラス名への依存を除去できない場合
* せめてクラス内で分離し、依存オブジェクトは注入したままにする
* そのクラス名を使ったオブジェクトの生成責務は別の箇所に分離・隔離する

#### 外部メッセージの隔離と除去
* 外部オブジェクト.外部メッセージとなっている場合、この依存がコードを脆くする
  * 例`wheel.diameter`：wheelオブジェクトがdiameterに応答することに依存している
  * このコードがクラス内に散りばめられた場合は、```def diameter wheel.diameter end```とカプセル化することで、外部への依存コードをDRYにして**隔離**できる(wrapper method)
* 依存方向を逆向きにする(**Dependency Inversion**)
  * ギア比を計算したいとき、ギアがホイールを呼び出すのか、ホイールがギアを呼び出すのか？これは逆転させられる

#### メッセージの引数(順番・デフォルト値・外部インタフェース)
* 引数にハッシュを使う
* 受信オブジェクトが明示的にデフォルト値を設定しておく
  * `args[:wheel] || 30 #keyがなければnil->30が選択される`
  * `args[:isMale] || true #keyがなくてもfalseでも、右側のtrueが選択される`
  * `args.fetch(:isMale, true) #キーがないときに、trueが選択される`
  * `Hash.merge`を使う
* 外部インタフェースが固定化しているときは、それを呼び出すだけ責務を持つWrapperMethodを作り、引数をハッシュで受取ることで隠蔽できる

#### 依存チェーン(Low Of Demeter)
* 「『何かをしるオブジェクト』を知るオブジェクト」を知るオブジェクト
* 遠くのオブジェクトの存在とメッセージの名前を知っている依存

#### コードに依存するテストコード

### ドメインオブジェクト=データと振る舞いを持つ名詞
* 業務ドメインの一部を表す「単語」、特に「名詞」
* 「データ」「振る舞い」を持つ「名詞」クラスにふさわしい。
* かんたんに見つけられるが、アプリケーションの中心にはならない。むしろ罠。

### メッセージ自動移譲の仕組み
* もし、クラスorロールを継承しておいて、「実装していない」というエラーを出すのは、自ら「そのサブクラスでない」とか「そのロールではない」と言っているようなもの。
  * 抽象が大きいので分割する
  * 抽象化できる共通項がないので、継承しない
* LSP(Liskov substitution Principle)
  * 継承したクラス・ロールは、継承元の代理で利用可能であるべき
#### クラス継承 = クラスを共有する(is-a)
#### モジュール = ロールを共有する(behaves-like-a)

### コンポジションで組み上げる (has-a)
* 自分が消えると、参照先も消える
* メッセージは自動移譲しないので、自身で参照先のオブジェクトへメッセージを送る

### アグリゲーション(has-a)
* 自分が消えても、参照先は消えない

### オブジェクト指向言語とは
#### オブジェクト指向言語と手続き型言語の違い
#### クラスとオブジェクト、インスタンスの違い

***

## 設計のツールなど
### 良い設計の特徴=TRUE
* Transparent = 見通しがよい
* Reasonable = 合理的
* Usable = 利用性がよい
* Exemplary = 模範的

これらを守るには、
* それぞれのクラスが単一責任の原則を守るようにすること


### 設計原則
#### Single Responsibility(どんな些細な事もDRYによってTRUEとなる)
* インスタンス変数がカプセル化されていること
  * 参照される責任を１箇所に集める(データではなく、振る舞いに依存させる)
  * 直接`@number`ではなく、`attr_reader :number` のようにメソッドにしてから参照する
* データ構造がカプセル化されていること
  * データ構造を解釈する責任を１箇所に集める
  * データ構造がむき出し(`cell[0],cell[1]`)だと、配列の構造を解釈する箇所が散らばるので、(`wheel.rim, wheel.tire`)というようにカプセル化する
* それぞれのメソッドの責任を単一にすること
  * すべてのメソッドが単一の責任を持つようになると、クラスが明確になる
  * コメントする必要がないほど短くなり、名前がコメントになる
* パブリックメソッドが、責任の説明として解釈できるものであること
  * クラスの責任を明確に述べる契約書

#### Open Closed
#### Liskov substitution
#### Interface Segregation
#### Dependency Inversion(依存性逆転)
#### Composition over Inheritance

### ユースケース
### シーケンス図
### クラス図

### パターン
適切に選び使うべき。

### メトリクス
ruby metricsなどでの静的解析






























































***

## なぜオブジェクト指向設計なのか？

* 将来の変更に耐えうる設計が必要なアプリケーションが存在する、そして、
* 開発は「仕様設計」と「ソフトウェア設計」の決定の連続で進むから。

### 「仕様設計」は協調作業によって進む
* ソフトウェアで問題解決をしたい人
  * ..だけで進めると「非現実的な仕様」ができあがる
* ソフトウェアを作るプロフェッショナル
  * ..だけで進めることはできない(仕様がないから)
* 協調作業によって、「現実的な仕様設計」を行うことができる

### 「ソフトウェア設計」は繰り返しのプロセスで進む
* 「良いソフトウェア設計」は、いま・未来において、常にコスパに優れているべき
  * 現時点で「サクっ」とコスパが良く、未来ではコスパの悪い拡張や変更するたびにバグを生むような設計が優れているわけがない
  * 現時点で「作るのに時間がかかる..」ようにコスパが悪く、未来の拡張性や変更容易性を保護している設計も優れているわけではない
  * このトレードオフを同時に達成して、はじめて良いソフトウェア設計となる
* 同時に達成するには、「具体的な設計からはじめて抽象的な設計に置き換える」プロセスを踏む必要がある
  * はじめから、最適な、あらゆるパターンに対応できる抽象的な設計はできない。
    * 情報が足りず、次の仕様設計のフィードバックが必要な場合があったり、
    * 一度、具体的なケースを書いてみないと、何を抽象化するべきかがわからない
  * 一方で、具体的な設計のままだと、拡張性を損なう
    * ※ただし、設計してみて「変更が加わっても周囲に影響がない」場合は、そのままでいい(という発見が、設計したあとで、見つかるパターンもある)
  * よって、具体的な設計をしてみて「この部分に変更が加わったら、別の箇所が壊れる」というような場合は、拡張性を損なっているので、その部分を抽象的な設計に置き換えて、影響を最小化する(ちょうど画家が何度も線を書いたり消したりするように、何度も行う)
* 繰り返しのプロセスの中で、変更を歓迎するコードにしておく

### 繰り返しの試行錯誤で設計は進む
* 未来を予想しすぎた仕様設計は「非現実的な仕様」「誤ったソフトウェア設計」となる可能性がある
  * 「こんな機能が欲しい！」という要望は問題ないが、それが実現できそうか？どう実現するか？何とどう連携するか？など細かいレベルでの仕様は、ソフトウェアが成長してこないとわからないことが多い
  * 設計が早すぎる、つまり必要な調整がわかるにはまだまだ手前の時点で設計が行われると、コードには初期の間違った理解が固く埋め込まれる
* 無駄に詳細を決めすぎないように、一度に作る単位を小さくする
  * 未来を予想した作り込みをしないこと(YAGNIに反する)
  * 作成する機能やアイデアについても、未来を予想した作り込みをしないこと
* 小さな単位で作った結果を見て、次の「仕様設計」を行い「現実的な仕様設計」を作る
* これを繰り返して設計は進んでいく
  * この繰り返しで当初は思いつかなかった良いアイディアを、途中で思いついたり、すぐに取り掛かれたりする嬉しい面もある

### 仕様は直前まで曖昧でいい。進みながらゴールを決める。
* 「繰り返しの試行錯誤」で何が起きるか予想できない
* 「最終的な仕様」がどうなるか、誰にもわからない
  * 「いつ終わるか？」もわからない。進みながら推定する他ない。
  * 「最終的な見積額」もわからない。予算を元に、どこまでできるか推定する方法もある。

### 利点(最初に詳細な仕様の設計を行う開発に対しての)
* 仮想的なシステム構築(詳細見積もり作業)にかかる費用が0秒＆0円
  * よって、「速い・安い」
* 仮想的なシステム構築に縛られない。
  * 構築する「直前まで、変更できる」
* 仮想的なシステム構築による「詳細な仕様の設計」が原因となる「非現実的な仕様設計・誤ったソフトウェア設計」を作り込む可能性が減る
  * 「最適な仕様・あるべき設計」を届けられる

### オブジェクト指向設計が最適
* オブジェクト指向設計は、オブジェクトが変更を許容できるような形で依存関係を構成するためのコーディングテクニックが集まったモノ
* 繰り返しの設計行為で、依存関係を構成する

### 営業的なこと
* 時間生産型受託開発が良いかも..
* 請負開発を前提に考えるとわかりにくいので「見積もりのカラクリ」を伝える
  * 「見積もり」をするということは、「仮想的にシステム構築をしている」ということ
  * 仮想的な構築にかかる費用や、デメリットは？(上で書いた)
* 仮想的な構築をやめて、試行錯誤の繰り返しで仕様設計を行う方が安く速く、品質も確かなものが作れる
