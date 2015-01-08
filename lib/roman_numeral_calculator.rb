module RomanNumeralCalculator
  def self.new(segment, converter)
    case segment
    when Product.new(segment, converter)
      Product.new(segment, converter)
    when Subtract.new(segment, converter)
      Subtract.new(segment, converter)
    else
      Add.new(segment, converter)
    end
  end
  class Base
    attr_reader :segment, :converter
    def initialize(segment, converter)
      @segment = segment
      @converter = converter
    end
  end

  class Add < Base
    def value
      converter.character_map.values_for(segment).first
    end
  end

  class Subtract < Base
    def value
      first, second = *converter.character_map.values_for(segment)
      second - first
    end

    def ===(other)
      other.first != '(' &&  other.size > 1
    end
  end

  class Product < Base
    def value
      result = converter.class.new(segment.first[1..-2]).to_i
      result * 1000
    end

    def ===(other)
      other[0].start_with?('(')
    end
  end
end
