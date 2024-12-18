class Memory
  attr_reader :register_a, :register_b, :register_c

  def initialize(register_a, register_b, register_c)
    @register_a = register_a
    @register_b = register_b
    @register_c = register_c
  end

  def to_s
    "A: #{@register_a.value}, B: #{@register_b.value}, C: #{@register_c.value}"
  end

  def get_register_val(type)
    case type
    when 'A'
      @register_a.value
    when 'B'
      @register_b.value
    when 'C'
      @register_c.value
    end
  end

  def overwrite_register(type, value)
    case type
    when 'A'
      @register_a.value = value
    when 'B'
      @register_b.value = value
    when 'C'
      @register_c.value = value
    end
  end
end
