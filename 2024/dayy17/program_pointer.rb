class ProgramPointer
  attr_accessor :cursor

  def initialize
    @cursor = 0
  end

  def increment(by = 1)
    @cursor += by

    self
  end

  def set(cursor)
    @cursor = cursor

    self
  end
end
