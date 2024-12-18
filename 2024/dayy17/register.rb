class Register
  attr_accessor :value
  attr_reader :type

  def initialize(type, value)
    @type = type
    @value = value
  end
end
