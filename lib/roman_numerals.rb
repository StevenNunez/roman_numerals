require "roman_numerals/version"

class RomanNumeral
  attr_reader :characters
  I = 1
  V = 5
  X = 10
  L = 50
  C = 100
  D = 500
  M = 1000

  def initialize(characters)
    @characters = characters
  end

  def to_i
    Object.const_get("#{self.class}::#{characters}")
  end
end
