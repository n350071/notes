#You can eliminate this duplication by using Extract Method in both classes
#and then Pull Up Method.
#
#Fields, Jay. Refactoring: Ruby Edition (Addison-Wesley Professional Ruby Series) (Kindle Location 1055). Pearson Education. Kindle Edition.

class Messagnger
  def extract_method(time) # (and also, pull up Method)
    ret_str = "#{time.strftime "%Y%m%d"} "
    ret_str << "Hello! World!"
  end
end

class Blue_msger < Messagnger
  #def extract_method(time)
  #  ret_str = "#{time.strftime "%Y%m%d"} "
  #  ret_str << "Hello! World!"
  #end

  def open_chat(time)
    ret_str = extract_method(time)
    ret_str << "This is the blue messanger!"
  end
end

class Green_msger < Messagnger
  #def extract_method(time)
  #  ret_str = "#{time.strftime "%Y%m%d"} "
  #  ret_str << "Hello! World!"
  #end

  def open_chat(time)
    ret_str = extract_method(time)
    ret_str << "This is the green messanger!"
  end
end

# -- before refactoring --

#class Messagnger
#end
#
#class Blue_msger < Messagnger
#  def open_chat(time)
#    ret_str = "#{time.strftime "%Y%m%d"} "
#    ret_str << "Hello! World!"
#    ret_str << "This is the blue messanger!"
#  end
#end
#
#class Green_msger < Messagnger
#  def open_chat(time)
#    ret_str = "#{time.strftime "%Y%m%d"} "
#    ret_str << "Hello! World!"
#    ret_str << "This is the green messanger!"
#  end
#end
