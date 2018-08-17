#Method. If the code is similar but not the same,
#you need to use Extract Method to separate the similar bits from the different bits.
#You may then find you can use Form Template Method.
#
#Fields, Jay. Refactoring: Ruby Edition (Addison-Wesley Professional Ruby Series) (Kindle Locations 1055-1056). Pearson Education. Kindle Edition.

# applied the 'Template Method pattern'
class Messagnger
  def open_chat(time)
    ret_str = making_header(time)
    ret_str << "This is the " + diff_bits + " messanger!"
  end
  def making_header(time)
    ret_str = "#{time.strftime "%Y%m%d"} "
    ret_str << "Hello! World!"
  end
end

class Blue_msger < Messagnger
  def diff_bits
    'blue'
  end
end

class Green_msger < Messagnger
  def diff_bits
    'green'
  end
end

# -- before refactoring --
#
#class Messagnger
#  def making_header(time)
#    ret_str = "#{time.strftime "%Y%m%d"} "
#    ret_str << "Hello! World!"
#  end
#end
#
#class Blue_msger < Messagnger
#  def open_chat(time)
#    ret_str = making_header(time)
#    ret_str << "This is the blue messanger!"
#  end
#end
#
#class Green_msger < Messagnger
#  def open_chat(time)
#    ret_str = making_header(time)
#    ret_str << "This is the green messanger!"
#  end
#end
