require "roman_numerals/version"

class RomanNumeral
  attr_reader :characters
  def initialize(characters)
    @characters = characters
  end

  def to_i
    tokenize(characters).inject(0, &roman_arithmatic)
  end

  private

  def roman_arithmatic
    lambda do |total, segment|
      total + RomanSegment.new(segment).value
    end
  end

  def tokenize(characters)
    characters.chars.slice_when do |before, after|
      first = RomanCharacter.value_for(before)
      second = RomanCharacter.value_for(after)
      first >= second
    end
  end
end

class RomanSegment
  def self.new(segment)
    if segment.size > 1
      SubtractiveSegment.new(segment)
    else
      AdditiveSegment.new(segment)
    end
  end
end

class AdditiveSegment
  attr_reader :segment
  def initialize(segment)
    @segment = segment
  end

  def value
    RomanCharacter.values_for(segment).first
  end
end

class SubtractiveSegment
  attr_reader :segment
  def initialize(segment)
    @segment = segment
  end

  def value
    first, second = *RomanCharacter.values_for(segment)
    second - first
  end
end

class RomanCharacter
  I = 1
  V = 5
  X = 10
  L = 50
  C = 100
  D = 500
  M = 1000

  def self.value_for(character)
    Object.const_get("#{self}::#{character}")
  end

  def self.values_for(characters)
    characters.map do |character|
      Object.const_get("#{self}::#{character}")
    end
  end
end
