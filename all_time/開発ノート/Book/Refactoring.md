# Refactoring

---
# Summary
* リファクタリングの原則
* コードのニオイ２５選
* リファクタリング実践７タイプ
  * メソッドの構成(20)
  * 機能をオブジェクト間で動かす(6)
  * データの構成(17)
  * 条件文をシンプルにする(9)
  * メソッドコールをシンプルにする(16)
  * 一般化する(11)
  * 大きなリファクタリング(4)

---
# Chapter2.Principles in Refactoring

## Why Should You Refactor ?
* Refactoring Improves the Design of Software
* Refactoring Makes Software Easier to Understand
* Refactoring Helps You Find Bugs
* Refactoring Helps You Program Faster
  * Improving Design, Improving Readability, Reducing Bugs, all these improve quality. But doesn't all this reduce the speed of development?

## When Should You Refactor ?
* always!

## The Rule of Three
1. Refactor When You Add Function
  * To understand
  * To improve design to add a feature easily
1. Refactor When You Need to Fix a Bug
  * To making code understandable
1. Refactor As You Do a Code Review
  * it is help for large review group that is UML and CRC (Class-Responsibility-Collaboration cards)

## Problem with Refactoring
### changing Interfaces
* 'the published interface'
  * There is a problem only if the interface is being used by code that you cannot find and change.
  * you have to retain both the old interface and the new one, at least until your users have had a chance to react to the change.
  * the published interface is useful, but it comes with a cost. So, don't publish interfaces unless you really need to. This may mean modifying your code ownership rules to allow people to change other people's code to support an interface change.

###  Databases
### Design Changes That Are Difficult to Refactor
* framework
* architecture

## When Shouldn't You Refactor?
* the current code does not work, rewite.
* A compromise route is to refactor a large piece of software into components with strong encapsulation. Then you can make a refactor-versus-rebuild decision for one component at a time.
* When you are close to a deadline.
* The most costly refactoring is refactoring for academic/your philosophical purposes.

## Refactoring and Design
* you don't do any design at all. you just code the first approach that comes into your head, get it working, and then refactor it into shape.
* Although doing only refactoring does work, it is not the most efficient way to work. Even the extreme programmers do some design first. They will try out various ideas with CRC cards or the like until they have a plausible first solution.
* if you don't refactor. there is a lot of pressure in getting that up-front design right. The sense is that any changes to the design later are going to be expensive.

### It Takes A While to Create Nothing
* The lesson is: Even if you know exactly what is going on in your system, measure performance; don't speculate.

### Refactoring and Performance
* Software has been rejected for being too slow.
* Refactoring certainly will make software go more slowly, but it also makes the software more amenable to performance tuning.
* Three are three general approaches
  * time budgeting, used often in hard real-time systems.
    * That component must not exceed its budget, although a mechanism for exchanging budgeted times is allowed.
    * This technique is over kill for other kind of systems
    * use this technique for such like heart pacemakers
  * the constant attention approach
    * it does not work very well
    * you find that they waste most of their time in a small fraction of the code.
  * Optimize only a specific process to tune
    * you begin by running the program under a profiler that monitors the program and tells you where it is consuming time and space.

---
# Chapter3.Bad Smells in Code (25 smells)
---
# Bloaters(肥満)
## Long Method
* comments : Whenever we feel the need to comment something, we write a method instead. A good technique is to look for comments. They often signal this kind of *semantic distance* . Even a single line is worth extracting if it needs explanation
    * Extract Method
* so many parameters and temporary variables
    * Replace Temp with Query
    * Replace Temp with Chain  
* Conditionals and loops
  * Decompose Conditional
  * Collection Closure Methods
  * Extract Method

## Large Class
* too many instance variables
* too long methods
  * Extract Class
  * Extract Module
  * Extract Subclass

## Primitive Obsession
* Signs and Symptoms
  * use of primitive instead of small objects for simple tasks
* Treatment
  * Replace Data Value with Object
  * if you have conditionals that depend on a type code
    * Replace Type Code with Polymorphism
    * Replace Type Code with Module Extension
    * Replace Type Code with State/Strategy
  * if you have a group of instance variables,
    * Extract Class
  * if you find yourself picking apart an array,
    * Replace Array

## Long Parameter List
* Replace Parameter
* Preserve Whole Object
* Introduce Parameter Object
* Introduce Named Parameter

## Data Clumps
* Signs and Symptoms
  * same three or four data items together in many places
* Treatment
  * Extract Class (they should be into the extract class)
  * Introduce Parameter Object
  * Introduce Preserve Whole Object
---
# Object Orientation Abusers
## Case Statements
* Signs and Symptoms
  * You can find case statement
* Treatment
  * You should consider polymorphism
    * Extract Method to extract the case statement
    * Move Method to get it onto the class where the polymorphism is needed
    * Replace Type Code with Polymorphism
    * Replace Type Code with Module Extension
    * Replace Type Code with State/Strategy
* exception
  * a few cases that affect a single method
    * Replace Parameter with Explicit Method
    * Introduce Null Object

## Temporary Field
* Signs and Symptoms
  * An object which an instance variable is set only in certain circumstances.
* Treatment
  * Use Extract Class with these variables and the methods that require them. The new object is a Method Object.

## Refused Bequest
* Signs and Symptoms
  * Subclasses pick just a few methods and data of their parents.
* Treatment
  * If inheritance makes no sense and the subclass really does have nothing in common with the superclass, eliminate inheritance in favor of **Replace Inheritance with Delegation.**
  * If inheritance is appropriate, get rid of unneeded fields and methods in the subclass. Extract all fields and methods needed by the subclass from the parent class, put them in a new subclass, and set both classes to inherit from it ( **Extract Superclass** ).
  * The hierarchy is wrong

## Alternative Classes with Different Interfaces
* Signs and Symptoms
  * Methods do the same things but method name are different.
* Treatment
  * Rename Methods to make them identical in all alternative classes.
  * Move Method, Add Parameter and Parameterize Method to make the signature and implementation of methods the same.
  * If only part of the functionality of the classes is duplicated, try using Extract Superclass. In this case, the existing classes will become subclasses.
  * After you have determined which treatment method to use and implemented it, you may be able to delete one of the classes.

---
# Change Preventers
## Divergent Change (変更が分岐してアチコチへ伝搬する)
* Signs and Symptoms
  * When one class is commonly changed in different ways for different reasons.
* Treatment
  * identify everything that changes for a particular cause
  * Extract Class

## Shotgun Surgery
* Signs and Symptoms
You whiff this when you make a kind of change, you have to make a lot of little changes to a lot of different classes.
* Treatment
  * Move Method
  * Move Field
    * into single class(find or create)
      * find it
      * create it
      * Inline Class

## Parallel Inheritance Hierarchies
* Signs and Symptoms
  * a special case of shotgun surgery
  * every time you make a subclass of one class, you also have to make a subclass of another
  * the prefixes of the class names in one hierarchy are the same as the prefixes in another hierarchy
* Treatment
  * To make sure that instances of one hierarchy refer to instances of the other
    * Move Method
    * Move Field
      * the hierarchy on the referring class disappears

---
# Dispensables
## Comments
* Signs and Symptoms
  * comments often are used as a deodorant
    * you look at thickly commented code and notice that the comments are there, because the code is bad
* Treatment
  * If you need a comment to explain what a block of code
    * Extract Method
  * you still need a comment to explain what it does
    * use Rename Method
  * If you need to state some rules about the required state of the system
    *  use Introduce Assertion
* Note
  * When you feel the need to write a comment, first try to refactor the code so that any comment becomes superfluous.
  * A comment is a good place to say WHY you did something.

## Duplicated Code
* if you see the same structure in more than one place
* same expression in two methods of the same class
* two sibling subclasses (brother)
  * Template Method
  * Substitute Algorithm
  * Extract Surrounding Method
* two unrelated class
  * Extract Class
  * Extract Module
  * Where should be the duplicated Method located ?

## Lazy Class
* Signs and Symptoms
  * A class that isn't doing enough to pay for itself should be eliminated
* Treatment
  * You let the class die
  * if it's a subclass or modules
    * Collapse Hierarchy
  * Useless components
    * should be subjected to Inline Class or Inline Module

## Data Class
* Signs and Symptoms
  * have attributes and nothing else
  * no responsibility class
* Treatment
  * Use Remove Setting Method on any instance variable that should not be changed.
  * if you have collection instance variables
    * check Encapsulation
  * SRP
    * Try to use Move Method, Extract Method, Hide Method to give its nature responsibility of the role

## Speculative Generality => YAGNI
* Signs and Symptoms
  * Codes that isn't used, it's designed for future.
    * "oh, I think we need the ability to do this kind of thing someday"
    * all sorts of hooks and special cases to handle things that aren't required
* Treatment
  * if the code aren't doing much
    * use Collapse Hierarchy
  * Unnecessary delegation
    * can be removed with Inline Class
  * Method with unused parameters
    * should be subject to Remove Parameter
  * methods name with odd names
    * should be brought down to earth with Rename Method.

---
# Couplers
## Feature Envy
* Signs and Symptoms
  * a method that seems more interested in a class other than the one it actually is in
* Treatment
  * Move Method
  * Extract Method
  * The heuristic is to determine which class has most of the data and put the method with that data
  * Strategy Pattern
  * Visitor Pattern
  * Self-Delegation pattern
* Idea
  The fundamental rule of thumb is to put things together that change together. Data the behavior that references that data usually change together, but there are exceptions.

## Inappropriate Intimacy
* Signs and Symptoms
  * One class **uses the internal fields and methods of another class.**
* Treatment
  * Move Method and Move Field to separate the pieces to reduce the intimacy. See whether you can arrange a Change Bidrectionl Association to Undirectional.
  * If the classes do have common interests,
    * use Extract Class to put the commonality
    * use Hide Delegate to let another class act as go-between
  * Inheritance often can lead to over-intimacy
    * Replace Inheritance with Delegation(if it's needed)

## Message Chains
* Signs and Symptoms
  * Violation of LoD
* Treatment
  * Hide Delegate
  * alternative way (less chain)
    * See what the resulting objet is used for. See whether you can use Extract Method to take a piece of the code that uses it and then move Method to push it down the chain.

## Middle Man
* Signs and Symptoms
  * If half or more of the methods are delegating to other class.Why does it exist at all?
* Treatment
  * Remove Middle Man
    * Encapsulation, Delegation
* When To Ignore
  * a middle man may have been added to avoid interclass dependencies.
  * some design patterns create middle man on purpose(Proxy, Decorator)

---
# Other Smells
## Incomplete Library Class
* Signs and Symptoms
  * Library doesn't provide feature that we need
* Treatment
  * Use Ruby's open classes
    * Move Method to move the behavior needed directly to the library class
  * Other Language
    * Introduce Foreign Method (few change)
    * Introduce Local Extension (big change)

## Metaprogramming Madness
* Signs and Symptoms
* Treatment
  * if it's not necessary
    * Replace Dynamic Receptor with Dynamic Method Definition
    * Extract Method
  * if it's truly needed
    * Isolate Dynamic Receptor to separate concerns

## Disjointed API (支離滅裂)
* Signs and Symptoms
  * with many configuration options
  * The same configuration options will be used over and over
* Treatment
  * Introduce Gateway
  * Introduce Expression Builder

## Repetitive Boilerplate
* Signs and Symptoms
  * method called from multiple places, like attr_reader
* Treatment
  * declarative statement like attr_reader

---

# Chapter4. Building Tests
## Developer and Quality Assurance Tests
* Developer tests is written to improve productivity
* It is better to write and run incomplete tests than not to run complete tests
* When to stop writing tests ?
  * You should concentrate on where the risk is.
  * it's danger to write too many tests that test every combination of everything.
* Inheritance and Polymorphism makes testing harder
  * combination alternative tests boil down the risks

---

# Chapter5.Toward a Catalog of Refactorings
## Format of the Refactorings
1. name
1. summary
1. motivation
1. mechanics
1. examples

---
# Chapter6.Composing Methods
リファクタリングでは、メソッドが長すぎる問題が大半であり、メソッドを適切に構成することに最もパワーを費やす。ポイントはExtract Method。

## Extract Method
長過ぎるメソッドを分けてクリアにする
* Summary
  * You have a code fragment that can be grouped together
  * TL;TR
  * If extract improves clarity, do it, even if the name is longer than the code you have extracted
* Motivation
  * too long
    * The length is not the issue
    * The key is the semantic distance between the method name and the method body
  * needs a comment to understand its purpose

## Inline Method
やりすぎた抽象化を戻す
* Summary
  * A method's body is as clear as its name
* Motivation
  * too much indirection
    * Indirection can be helpful, but needless indirection is irritating.
    * It seems that every method does simple delegation to another method, and I get lost in all the delegation.
  * too much factored
    * A group of method that seem badly factored. You can inline them all into one big method and then re-extract the methods.

## Inline Temp
意味のない一時変数を消す
```
base_price = an_order.base_prise
return(base_prise > 100)
↓
return(an_order.base_price > 100)
```

## Replace Temp With Query
一時変数をメソッドに置き換える
* Summary
  * You are using a temporary variable to hold the result of an expression.
  * Extract the expression into a method. Replace all references to the temp with the expression. The new method can then be used in other methods.
* Motivation
  * メソッド内のコンテキストを増加させて、見通しを悪くする
  * Extract Methodの前段

## Replace Temp With Chain
ずっと自分のターンのメソッドチェーンにして、一時変数を消す
```
mock = Mock.new
mock.expects(:a_method_name).with('arguments').returns([1, :array])
```
* Summary
  * You are using a temporary variable to hold the result of an expression
  * *Change the methods to support chaining, thus removing the need for a temp*
* Motivation
  * provide an interface that allows you to compose code that reads naturally
  * removes the temp variable
  * Not violate LoD
    * only one object (return self)

## Introduce Explaining Variable
説明的な一時変数を導入する

## Split Temporary Variable
一時変数を使いまわさずに、都度、分ける

## Remove Assignments to Parameters
パラメータに再代入せずに、一時変数を使う
* Motivation
  * 値渡し、参照渡しの混乱が生ずるため
  * Rubyは値渡し

## *Replace Method with Method Object* !!
ローカル変数があって分割できないメソッドを別のクラスに分割し(Method Object)、依存方向を自身に向ける(`initilaize(self,other_params,..)`)ことで、自身の依存度を上げずに、メソッドを分割する準備を整える

## Substitute Algorithm
シンプルで簡単なアルゴリズムに置き換える

## Replace Loop With Collection Closure Method
Collectionでループを使わずに、Collection Closureで結果を出す

## Extract Surrounding Method
ほとんど同じようなメソッドが２つあって、コードの途中が少し違うようなものは、`block`と`yield`で違いを表現して、まとめよう

## Introduce Class Annotation
メソッドを`attr_reader`のアノテーションのように定義する

## Introduce Named Parameter
パラメータをHashにして、キー名で説明する
`object.method(:author_id => 5)`

## Remove Named Parameter
明らかな場合は、Named Parameterは冗長(詳細はカタログ参照)

## Remove Unused Default Parameter

## Dynamic Method Definition
"簡潔"に定義できて、重複が減るなら、Dynamicに定義しよう

## *Replace Dynamic Receptor with Dynamic Method Definition* !
必須メソッドを用意して、method_missingなしで動くようにする

## *Isolate Dynamic Receptor* !
method_missingを利用して様々な作業をする場合は、その責任をmethod_missingごと、別の新しいクラスに移譲する


## Move Eval from Runtime to Parse Time
Evalの定義をメソッド自身にやらせて、パフォーマンスの問題解決を先延ばしにする


---
# Chapter7.Moving Features Between Objects
クラス設計は、責任をどこに置くかの設計であり難しいが、リファクタリングで解決できる。主にMove Method,Move Filedで解決できる。責任を負いすぎたら、Extract Class,Extract Moduleであり、少なければInline Classでマージする。別のクラスが使われているのであればHide Delegateであり、これによりインタフェースが変わるようであれば、Remove Middle Manを使う。

## Move Method
その責務を負うべきクラスへ置く（自然と、そのメソッドをよく使っているクラスだったりする）。どこに動かすかを決めるのが難しいときは、一旦、待って別のメソッドを動かしたりして明確になるのを待つ。Move Fieldを先にやると明確になりやすい。

## Move Field
変数を別のクラスへ移す。自身にはカプセル化を行う。

## Extract Class
複数の責務を持つクラスは、分割する。（必要に応じて参照を渡す）

## Inline Class
責務がほとんどないクラスは、マージする。（そのクラスに依存しているクラスへ）

## *Hide Delegate* !
LoD違反。クライアントが遠くのオブジェクトの使い方を知っているときは、その知識を隣のクラスへ埋め込んで移譲する。Forwardableモジュールを使った方法はカタログを参照。

## Remove Middle Man
Hide Delegateの逆。単純な移譲を増やしすぎてしまって、移譲クラスがただの伝書鳩になってしまったら、伝書鳩は抜いて、直接、操作する。

---
# Chapter8.Organizing Data
カプセル化しましょう

## Self Encapsulate Field
accessorを使ってフィールドをカプセル化する

## Replace Data Value With Object
はじめは単純だったデータでも、役割を持ち始めたら、オブジェクトにする

## *Change Value to Reference* !
object idで等しさを識別したいときや、真に同一のオブジェクトを扱いたいときは、Reference Objectを使う

* What is Reference and Value
  * References:
    * Equality is defined as *"the object id"*, that means "eql?"
    * when one real-world object corresponds to only one object in the program. References are usually user/order/product/etc. objects.
  * Values:
    * Equality is defined as *"the object value"*, that means "=="
    * one real-world object corresponds to multiple objects in the program. These objects could be dates, phone numbers, addresses, colors, and the like.

## *Change Reference to Value* !
データセットが等しければ、真に同一でなくても構わないときは、Value Objectを使う

## Replace Array with Object
Arrayに入ってるモノの意味がバラバラなら、そのArrayは、あるオブジェクトのデータである

## Replace Hash with Object
Hashに入っているモノの意味がバラバラなら、そのHashは、あるオブジェクトのデータである

## *Change Unidirectional Association to Bidirectional* !
２つのオブジェクトが、互いを利用させあいたいならば、双方向リンクにするべき

## Change Bidirectional Association to Unidirectional
双方向リンクが必要なくなったのであれば、必要ない方を消すべき

## Replace Magic Number with Symbolic Constant
マジックナンバー使うな

## *Encapsulate Collection* !
Array,Hashなどのコレクションは、カプセル化する

* クライアントオブジェクトによるデータ操作を防ぐために、コピーを渡す
* クライアントオブジェクトがデータ構造を知っている依存を減らすため、要素をadd/removeするメソッドを足す

## Replace Record With Data Class
レガシーなシステムの置き換え・APIに関わるときに、それらのデータと通信するインタフェースクラスを作ると便利

## Replace Type Code With Polymorphism
クラスをタイプ分けするようなデータは、クラスにして、ポリモーフィズムにする("Case Statements"のときにやる)

## *Replace Type Code with Module Extension* !
クラスをタイプ分けするようなデータを使うクラスは、実行中のモジュール拡張を使って、制御文を外そう。ただし、moduleは一度extendしてしまうと、removeが難しいので、removeしないときに限って'Replace Type Code With State/Strategy' の代わりに使う。

## Replace Type Code With State/Strategy
クラスをタイプ分けするようなデータを使うクラスは、ステートパターンを使って置き換える。'with Polymorphism' との違いがあまりわからないな。。。

置き換えるべきコードが、 Type codeをどの程度使っているかによって、分ける。

* 大部分→ "with Polymorphism" <- Ruby Duck Type でシンプルにやる
* 少し→ "with Module Extension" or "with State/Strategy"

## Replace Subclass with Fields
定数を変えて返す部分だけが変わるようなサブクラスは止めて、スーパークラスのフィールドに変える。（定数を返すだけのサブクラスは、責務がないも同然）

## Lazyily Initialized Attribute
Attributeの生成タイミングを、アクセスされた瞬間に変更する（`@emails ||= []`,`instance_variable_defined?`）。コードの可読性が目的。インスタンス変数とAttributeが混在して初期化などすると、初期化処理内で、混乱が生じやすい。そこで、初期化時に不要な手続きは、カプセル化することで、可読性をあげるのである。

## Eagerly Initialized Attribute
初期化処理を、initialize内にカプセル化したいときには、そこに戻す

---
# Chapter9.Simplifying Conditional Expressions
Decompose Conditional が大事

## Decompose Conditional
①条件文②thenやelseのあとの中身が複雑なら、Extract Methodせよ！(
```
if not_summer(date)
 charge = winter_charge(quantity)
else
 charge = summer_charge(quantity)
end
```
)

## Recompose Conditional
Rubyらしい条件式に書き換えて、(理解に時間のかかる)歪曲な条件文を消す(
```
parameters = params ? params :[]
=>
parameters = params || []
```
)

## Consolidate Conditional Expression
同じ結果を返す一連の条件文は、ひとつにまとめて、抽出せよ。コードが語る内容を「何を」から「なぜ」へ変える。

```
def disability_amount
  return 0 if @seiority < 2
  return 0 if @month_disabled > 12
  return 0 if @is_part_time
=>
def disability_amount
  return 0 if ineligable_for_disability?
```

## Consolidate Duplicate Conditional Fragments
各分岐内のコードの重複は、if〜endの外へ出そう。

## Remove Control Flag
(True/Falseの)Flagを使わずに、returnを使う。

## Replace Nested Conditional with Guard Clauses
メソッドが条件によって振る舞いを変えるのであれば、ガード構文(result)で置き換える。（ガードしたケースは「これはレアケース！」という強調にもなる）

## Replace Conditional with Polymorphism
オブジェクトのタイプ別に振る舞いを変えるコードは、ポリモーフィズムで置き換える。

## *Introduce Null Object* !
nilとの比較を繰り返しているなら、Null Objectと置き換える。

ポリモーフィズムの応用。オブジェクトにnullかどうかを聞いて振る舞いを決めるのではなく、nullだった場合の振る舞いを知っておくのは、そのオブジェクト自身なので、Null Object(missing-object)を生成して渡し、呼び出し側が意識することのないように、同じインタフェースで呼び出せるようにする。

Null Objectは一定なので、シングルトンパターンを使うこと。

Message-eating

## Introduce Assertion
状態を確認してから、本処理を実行するプログラムは、状態確認コードをassertionを使って、期待を明示しよう

---
# Chapter10.Making Method Calls Simpler
インタフェース大事！

## Rename Method
## Add Parameter
## Remove Parameter
## *Separate Query from Modifier* !
クエリ系メソッドとコマンド系メソッドは分けて管理する。（TDDにもこれ書いてあったな）ただし、スレッド時は同期して両方を実行するメソッドを追加する方法も考慮すること。

**良いルール：コマンド系メソッドは「戻り値なし」のみ** (Bertrand Meyer)

## Parameterize Method
```
def five_percent_raise ... end
def ten_percent_raise ... end
=>
def raise(percentage) ... end
```

## Replace Parameter with Explicit Methods
Parameterize Methodの逆。パラメータによって処理を分けるくらいなら、そもそも別のメソッドだということ。

## Preserve Whole Object
オブジェクトから値を取り出してメソッドを呼ぶ知識をメソッド内にカプセル化する。つまり、オブジェクトをそのままパラメータに渡す。

## Replace Parameter with Method
メソッド内でメソッドコールして取得することで、パラメータとしてもらう必要性をなくす

## Introduce Parameter Object
グループとして仲良くまとまっているパラメータは、オブジェクトにしよう

## Remove Setting Method
変数がimmutableであるべきであれば、setter methodは消すべき

## Hide Method
Make the method private, if no class use it.

## Replace Constructor with Factory Method
コンストラクターが、①条件によって作るオブジェクトを変えるor②限定的な状況でしか使われないようであれば、ファクトリーメソッドパターンを導入せよ

## Replace Error Code with Exception
エラーコードを返すようであれば、Exceptionを投げるようにしましょう

## Replace Exception with Test
Exceptionを使って、呼び出し元が確認をするようなコードであれば、それはExceptionの役割ではなくてifによるテストなので、ifに置き換える

## Introduce Gateway
複雑な外部のAPIやリソースにアクセスしたいときは、Gatewayを導入して、アクセスの知識をカプセル化しよう。カタログ参照。 （Extract Surrounding Methodも活用してるっぽい）

Railsでは、ActiveRecordをGatewayとして利用している。

## Introduce Expression Builder
これは、、、Adapter Pattern とは違うのかな？あるいはラッパーとか。
---
# Chapter11.Dealing With Generalization
メソッドを抽象化・具象化を行ったり、クラスやモジュールに分けたりする。階層ではなく、移譲で対応したいときなど。

## Pull Up Method
サブクラスで重複となるメソッドがあれば、スーパークラスへ引き上げる。重複を消すのは重要である。一見してわからないような、 Parameterize Methodすることによって同じになるメソッドであれば、さきにParameterize MethodしてからPull Up Methodする方法もある。Moduleにも有効。

似ているが違うメソッドなら Form Template Method を利用するとよい。Substitute Algorithmで同じにする方法もある。

## Push Down Method
LSPに違反しているならば、サブクラスに実装させましょう。

## Extract Module
２，３のクラスに同じ振る舞いをするメソッドがあるならば、モジュールに抜き出そう。（クラスA,クラスBが同じ振る舞いXを持つなら、クラスCを作りXを移してAのインスタンスを持ち、AがCのインスタンスへ移譲するようにする..が、XがA,Bにしか意味がないなら、移譲の分だけ複雑なので、モジュールを選択する）

**A module should have a single responsibility, just like a class** A module that is difficult to name without using words like "Helper" or "Assistant" is probably doing too much.

## Inline Module
モジュールにしておく必要がなければ、クラスに戻す。

## Extract Subclass
一部のインスタンスでしか使われないメソッドがあるならば、サブクラスへ抽出する。

## Introduce Inheritance
２つのクラスに同一のメソッドがあるならば、継承を導入する

## Collapse Hierarchy
スーパークラスとサブクラスが、そんなに違わない..ならば、マージしてまとめる

## *Form Template Method* !
サブクラスに２つのメソッドがあり、同じオーダーに似たようなステップを踏むが、ちょっと異なる。（似たようなアルゴリズムでちょっと違う..あ！これはテンプレートメソッドパターンの使いどころだ！パブリックメッセージを新たに作って、くっつける。デザパタを狙って設計をする方法もあるが、作ってからリファクタリングで設計する方法もある！）

**Example が非常に長い！思っているよりも、テンプレートメソッドパターンの使い方は、応用が効くのかもしれない**

## Replace Inheritance with Delegation
継承にしておくほど結合度を高めたくないときは、「サブクラス」から「スーパークラス」へメッセージを移譲にしよう。（そもそも、継承は「メッセージ自動移譲の仕組み」と考えるととても納得がいく）

## Replace Delegation with Hierarchy
メッセージ移譲しているけれど、シンプルでクラスの全体に渡ってやっているようなら、それはすでに継承です。

## Replace Abstract Superclass with Module
明示的にインスタンス化するつもりのないスーパークラスは、モジュールに置き換えることで、意図を伝える

---
# Chapter12.Big Refactorings
これまでの各章で、１つずつ「動かす」方法を学んだ。しかし、リファクタリング全体を通してやりたいことは、なんだっただろうか？

## The Nature of the Game

## Why Big Refactorings Are Important
リファクタリングする理由は楽しいからではなく、それをしないと実装できないと思える何かを実装するためにするのだ。

## Four Big Refactorings
### Tease Apart Inheritance
２つのことをする（責務を持った）階層構造があるなら、２つの階層構造を作り、一方の階層構造がもう片方の階層構造へ移譲する仕組みにする。階層のある層の各サブクラスが、同じ形容詞の名前のサブクラスを持つようであれば、２つのことをしている階層構造である可能性が高い。

### Convert Procedural Design to Objects
データと振る舞いを１つのオブジェクトに入れて、Extract Methodとそれに続くリファクタリングをかけ続け、手続き指向をオブジェクト指向な設計に変える

### Separate Domain from Presentation
コントローラーからドメインロジック・ビューロジックを抽出して、モデル・ビューへ移す。そして、ビューからは「ビューロジック以外」を抽出して、モデルへ移す。

* **MVCのポイントは、ユーザインタフェースのロジックとドメインのロジックを分けることにある。**
* コントローラーは常に、ユーザーのリクエストを受け付ける責務にのみ集中すべきである。

### Extract Hierarchy
たくさんのことをするクラスがあり、条件式がたくさんある部分があるのであれば、継承を使い、各サブクラスが各特別なケースを扱うように設計する。

（iOS7以下〜、iOS8、iOS9~で分けるみたいな？）

---
# Chapter13.Putting It All Together
「誰かがしくじったコードであろうと、絶対的な自信で、コードを良くして、進めることができる」くらいに落ち着きはじめたとき、十分なレベルに達したといえる、リファクタリングが。


# その他
## ポリモーフィズム
The essence of polymorphism is that instead of asking an object what type it is and then invoking some behavior based on the answer, you just invoke the behavior.
「聞くな、言え」
