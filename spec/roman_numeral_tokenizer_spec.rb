require 'spec_helper'

describe RomanNumeralTokenizer do
  class FakeCharacterClass
    def self.value_for(character)
      case character
      when 'I'
        1
      when 'V'
        5
      else
        42
      end
    end
  end

  class FakeConverterClass
    def character_map
      FakeCharacterClass
    end
  end

  it "groups single character as segment" do
    tokens = RomanNumeralTokenizer.call("I", FakeConverterClass.new)
    expect(tokens.length).to eq(1)
    expect(tokens).to eq([["I"]])
  end

  it "groups separate arrays if characters are of greater or equal value" do
    tokens = RomanNumeralTokenizer.call("III", FakeConverterClass.new)
    expect(tokens.length).to eq(3)
    expect(tokens).to eq([["I"], ["I"], ["I"]])
  end

  it "groups characters that form indicate subtractive relationship" do
    tokens = RomanNumeralTokenizer.call("IV", FakeConverterClass.new)
    expect(tokens.length).to eq(1)
    expect(tokens).to eq([["I", "V"]])
  end

  it "groups characters in parenthesis as 1 unit" do
    tokens = RomanNumeralTokenizer.call("(V)", FakeConverterClass.new)
    expect(tokens.length).to eq(1)
    expect(tokens).to eq([['(V)']])
  end

  it "groups multiple characters in parenthesis as 1 unit" do
    tokens = RomanNumeralTokenizer.call("(CCCX)MMMM", FakeConverterClass.new)
    expect(tokens.length).to eq(5)
    expect(tokens).to eq([["(CCCX)"], ["M"], ["M"], ["M"], ["M"]])
  end
end
