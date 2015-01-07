require 'spec_helper'

  describe RomanNumerals do
    # IV = 4
    # XXXIV = 34
    # CCLXVII = 267
    # DCCLXIV = 764
    # CMLXXXVII = 987
    # MCMLXXXIII = 1983
    # MMXIV = 2014
    # MMMM = 4000
    # MMMMCMXCIX = 4999
    it "converts single letters to decimal equivalent" do
      expect(RomanNumeral.new('I').to_i).to eq(1)
      expect(RomanNumeral.new('V').to_i).to eq(5)
      expect(RomanNumeral.new('X').to_i).to eq(10)
      expect(RomanNumeral.new('L').to_i).to eq(50)
      expect(RomanNumeral.new('C').to_i).to eq(100)
      expect(RomanNumeral.new('D').to_i).to eq(500)
      expect(RomanNumeral.new('M').to_i).to eq(1000)
    end
  end
