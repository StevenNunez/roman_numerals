class RomanNumeralTokenizer
  attr_reader :characters, :converter
  def initialize(characters, converter)
    @characters = characters
    @converter = converter
  end

  def call
    match = characters.match(/^(\(.*?\))?(\w*?)$/)
    large_numbers  = Array(match[1])
    small_numbers  = Array(match[2].chars
    .slice_when(&small_number_first))

    if large_numbers.any?
      [large_numbers] + small_numbers
    else
      small_numbers
    end
  end

  def self.call(characters, converter)
    new(characters, converter).call
  end

  private
  def small_number_first
    lambda do |before, after|
      first = converter.character_map.value_for(before)
      second = converter.character_map.value_for(after)
      first >= second
    end
  end
end
