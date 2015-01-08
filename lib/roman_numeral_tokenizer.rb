class RomanNumeralTokenizer
  attr_reader :characters, :character_class
  def initialize(characters, character_class)
    @characters = characters
    @character_class = character_class
  end

  def call
    match = characters.match(/^(\(.*?\))?(.*?)$/)
    large_numbers  = Array(match[1])
    small_numbers  = Array(match[2].chars
    .slice_when(&small_number_first))

    if large_numbers.any?
      [large_numbers] + small_numbers
    else
      small_numbers
    end
  end

  def self.call(characters, character_class)
    new(characters, character_class).call
  end

  private
  def small_number_first
    lambda do |before, after|
      first = character_class.value_for(before)
      second = character_class.value_for(after)
      first >= second
    end
  end
end
