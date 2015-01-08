class RomanNumeralCharacterMap
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
