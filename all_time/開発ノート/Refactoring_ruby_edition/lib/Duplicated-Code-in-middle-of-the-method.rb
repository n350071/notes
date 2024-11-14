#If the duplication is in the middle of the method,
#use Extract Surrounding Method.
#
#Fields, Jay. Refactoring: Ruby Edition (Addison-Wesley Professional Ruby Series) (Kindle Locations 1057-1058). Pearson Education. Kindle Edition.

class Part
  attr_reader :parent, :children, :name, :damage_per

  def initialize(name, damage_per=nil, parent=nil)
    @name, @parent = name, parent
    @damage_per = damage_per
    @children = []
    @parent.add_child(self) if @parent
  end

  def add_child(child)
    @children << child
  end

  # Second step, making the calling method pass a block to the 'Surrounding Method', and push the loginc into the block.
  def count_by_matching(&block)
    children.inject(0) do |count, child|
      count += 1 if yield child #child.name == name # the duplication is in the decision, and it can't be made WITHOUT context as to the state of the Part Object
      count + child.count_by_matching(&block)
    end
  end
  def find_parts_by_name(name)
    count_by_matching{|child_of_yield_argument| child_of_yield_argument.name == name}
  end
  # First step, 'Extract Method' on one of the duplication
  #def count_by_matching(name)
  #  children.inject(0) do |count, child|
  #    count += 1 if child.name == name # the duplication is in the decision, and it can't be made WITHOUT context as to the state of the Part Object
  #    count + child.count_by_matching(name)
  #  end
  #end
  #def find_parts_by_name(name)
  #  count_by_matching(name)
  #  #children.inject(0) do |count, child|
  #  #  count += 1 if child.name == name # the duplication is in the decision, and it can't be made WITHOUT context as to the state of the Part Object
  #  #  count + child.find_parts_by_name(name)
  #  #end
  #end

  def find_damaged_parts(damage_per)
    # Third step, modify this method to use the new 'Surrounding Method'
    count_by_matching{|child_of_yield_argument| child_of_yield_argument.damage_per >= damage_per}
    #children.inject(0) do |count, child|
    #  count += 1 if child.damage_per >= damage_per # the duplication
    #  count + child.find_damaged_parts(damage_per)
    #end
  end

end


# -- before refactoring --

#class Part
#  attr_reader :parent, :children, :name, :damage_per
#
#  def initialize(name, damage_per=nil, parent=nil)
#    @name, @parent = name, parent
#    @damage_per = damage_per
#    @children = []
#    @parent.add_child(self) if @parent
#  end
#
#  def add_child(child)
#    @children << child
#  end
#
#  def find_parts_by_name(name)
#    children.inject(0) do |count, child|
#      count += 1 if child.name == name
#      count + child.find_parts_by_name(name)
#    end
#  end
#
#  def find_damaged_parts(damage_per)
#    children.inject(0) do |count, child|
#      count += 1 if child.damage_per >= damage_per
#      count + child.find_damaged_parts(damage_per)
#    end
#  end
#
#end
