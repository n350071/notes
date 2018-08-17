# Following is equivalent
# () is needed if you use {} , cury brases is stronger than do-end.

event :happen do
  transitions from: :sleep, to: :wakeup
end

event(:happen){transitions from: :sleep, to: :wakeup }

# sometime {} is better for me.
# look this
aasm column: :status do
  state :a , initial: true
  state :b
  state :c
  state :d
  state :e
  state :f
  state :g
  state :h

  event(:a)   {transitions from: :set_up, to: :a }
  event(:b)   {transitions from: :a,  to: :b  }
  event(:c)   {transitions from: :b,  to: :c  }
  event(:d)   {transitions from: :b,  to: :d  }
  event(:e)   {transitions from: :d,  to: :e  }
  event(:f)   {transitions from: :e,  to: :f  }
  event(:g)   {transitions from: :e,  to: :g  }
end

aasm column: :status do
  state :a , initial: true
  state :b
  state :c
  state :d
  state :e
  state :f
  state :g
  state :h

  event :a do
    transitions from: :set_up, to: :a
  end
  event :b do
    transitions from: :a,  to: :b
  end
  event :c do
    transitions from: :b,  to: :c
  end
  event :d do
    transitions from: :b,  to: :d
  end
  event :e do
    transitions from: :d,  to: :e
  end
  event :f do
    transitions from: :e,  to: :f
  end
  event :g do
    transitions from: :e,  to: :g
  end
end
