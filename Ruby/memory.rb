# オブジェクトのメモリサイズを推定する
require 'objspace'
ObjectSpace.memsize_of "abc" # => 40
