# フックメソッドを追加/変更したいときは、配列に :after_create などを追記/変更してください
# フック元で定義したメソッドを使ってタイトルと内容を設定し、配信します。
# |obj| は引数であり、この例でいうと、 after_save(obj) となります。
[:after_save].each do |method|
  define_method method do |obj|
    @title, @body = obj.title, obj.body
    do_something
  end
end
