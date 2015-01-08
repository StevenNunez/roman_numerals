class RomanNumeralConverter
  attr_reader :characters, :tokens, :calculator, :character_map, :tokenizer
  def initialize(characters, calculator=RomanNumeralCalculator, character_map=RomanNumeralCharacterMap, tokenizer=RomanNumeralTokenizer)
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
