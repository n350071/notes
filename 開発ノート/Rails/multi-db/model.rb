class Model < ActiveRecord::Base
  establish_connection "slave_database"
end

# # masterを向いているコネクションは各クラスで共通のものを利用 => 高々5コネクション
# > Dog.connection.object_id
# #=> 70109750578740
# > Cat.connection.object_id
# #=> 70109750578740

# # slaveを向いているコネクションは、各クラスで別々のものを利用 => 5コネクション × クラス数
# # これはクラスが増えるたびにコネクション数が増えていく。
# > Display.connection.object_id
# #=> 70109788293000
# > Chair.connection.object_id
# #=> 70109768700800

# # ただし、やり方としては、ActiveRecord::Baseクラスのコード内コメントに、以下の記述あり。
# # ---コメント---
# # For example, if Course is an
# # ActiveRecord::Base, but resides in a different database, you can just say <tt>Course.establish_connection</tt>
# # and Course and all of its subclasses will use this connection instead.
