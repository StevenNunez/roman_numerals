require "roman_numerals/version"

class RomanNumeral
  attr_reader :characters, :tokens, :segment_class, :character_class
  def initialize(characters, segment_class=RomanSegment, character_class=RomanCharacter)
    @characters = characters
    @segment_class = segment_class
    @character_class = character_class

    @tokens = tokenize(characters)
  end

  def to_i
    tokens.map{|s| segment_class.new(s).value}.inject(:+)
  end

  private

  def tokenize(characters)
    RomanNumeralTokenizer.call(characters, character_class)
  end
end

class RomanSegment
  def self.new(segment, character_class=RomanCharacter)
    case segment
    when ProductiveSegment.new(segment, character_class)
      ProductiveSegment.new(segment, character_class)
    when SubtractiveSegment.new(segment, character_class)
      SubtractiveSegment.new(segment, character_class)
    else
      AdditiveSegment.new(segment, character_class)
    end
  end
end

class AdditiveSegment
  attr_reader :segment, :character_class
  def initialize(segment, character_class)
    @segment = segment
    @character_class = character_class
  end

  def value
    character_class.values_for(segment).first
  end
end

class SubtractiveSegment
  attr_reader :segment, :character_class
  def initialize(segment, character_class)
    @segment = segment
    @character_class = character_class
  end

  def value
    first, second = *character_class.values_for(segment)
    second - first
  end

  def ===(other)
    other.first != '(' &&  other.size > 1
  end
end

class ProductiveSegment
  attr_reader :segment, :character_class
  def initialize(segment, character_class)
    @segment = segment.first
    @character_class = character_class
  end

  def value
    result = RomanNumeral.new(segment[1..-2]).to_i
    result * 1000
  end

  def ===(other)
    other[0].start_with?('(')
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
      value_for(character)
    end
  end
end
