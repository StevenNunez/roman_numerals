class RomanNumeralConverter
  attr_reader :characters, :tokens, :calculator, :character_map, :tokenizer
  def initialize(characters, calculator=RomanCalculator, character_map=RomanCharacterMap, tokenizer=RomanNumeralTokenizer)
    @characters = characters
    @calculator = calculator
    @character_map = character_map
    @tokenizer = tokenizer
  end

  def to_i
    tokenizer.call(characters,self)
    .map{|s| calculator.new(s, self).value}
    .inject(:+)
  end
end

class RomanCalculator
  def self.new(segment, converter)
    case segment
    when ProductiveSegment.new(segment, converter)
      ProductiveSegment.new(segment, converter)
    when SubtractiveSegment.new(segment, converter)
      SubtractiveSegment.new(segment, converter)
    else
      AdditiveSegment.new(segment, converter)
    end
  end
end

class ComputationalSegment
  attr_reader :segment, :converter
  def initialize(segment, converter)
    @segment = segment
    @converter = converter
  end
end

class AdditiveSegment < ComputationalSegment
  def value
    converter.character_map.values_for(segment).first
  end
end

class SubtractiveSegment < ComputationalSegment
  def value
    first, second = *converter.character_map.values_for(segment)
    second - first
  end

  def ===(other)
    other.first != '(' &&  other.size > 1
  end
end

class ProductiveSegment < ComputationalSegment
  def value
    result = converter.class.new(segment.first[1..-2]).to_i
    result * 1000
  end

  def ===(other)
    other[0].start_with?('(')
  end
end

class RomanCharacterMap

  MAP = {
    "I" => 1,
    "V" => 5,
    "X" => 10,
    "L" => 50,
    "C" => 100,
    "D" => 500,
    "M" => 1000
  }

  def self.value_for(character)
    MAP.fetch(character)
  end

  def self.values_for(characters)
    characters.map do |character|
      value_for(character)
    end
  end
end
