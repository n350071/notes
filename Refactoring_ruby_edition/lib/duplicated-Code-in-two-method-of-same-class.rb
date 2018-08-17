class Message

  #The simplest duplicated code problem is when you have the same expression in two methods of the same class.
  #Then all you have to do is Extract Method and invoke the code from both places.
  #Fields, Jay. Refactoring: Ruby Edition (Addison-Wesley Professional Ruby Series) (Kindle Locations 1052-1054). Pearson Education. Kindle Edition.

  def date_stamp(time)
    msg = "Date: #{time.strftime "%Y%m%d"} "
  end

  def say_thank_you(time)
    msg = date_stamp(time)
    msg << "thank you"
  end

  def say_have_a_nice_day(time)
    msg = date_stamp(time)
    msg << "have a nice day"
  end

#  def say_thank_you(time)
#    msg = "Date: #{time.strftime "%Y%m%d"} "
#    msg << "thank you"
#  end
#
#  def say_have_a_nice_day(time)
#    msg = "Date: #{time.strftime "%Y%m%d"} "
#    msg << "have a nice day"
#  end

end
