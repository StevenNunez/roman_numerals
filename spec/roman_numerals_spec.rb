require 'spec_helper'

describe RomanNumerals do
  it "converts single letters to decimal equivalent" do
    expect(RomanNumeral.new('I').to_i).to eq(1)
    expect(RomanNumeral.new('V').to_i).to eq(5)
    expect(RomanNumeral.new('X').to_i).to eq(10)
    expect(RomanNumeral.new('L').to_i).to eq(50)
    expect(RomanNumeral.new('C').to_i).to eq(100)
    expect(RomanNumeral.new('D').to_i).to eq(500)
    expect(RomanNumeral.new('M').to_i).to eq(1000)
  end

  it "does additive math" do
    expect(RomanNumeral.new('II').to_i).to eq(2)
    expect(RomanNumeral.new('MDCLXVI').to_i).to eq(1666)
  end

  it "does subtractive math" do
    expect(RomanNumeral.new('IV').to_i).to eq(4)
    expect(RomanNumeral.new('IX').to_i).to eq(9)
    expect(RomanNumeral.new('XL').to_i).to eq(40)
    expect(RomanNumeral.new('XC').to_i).to eq(90)
    expect(RomanNumeral.new('CD').to_i).to eq(400)
    expect(RomanNumeral.new('CM').to_i).to eq(900)
  end

  it "passes these random tests" do
    expect(RomanNumeral.new('IV').to_i).to eq(4)
    expect(RomanNumeral.new('XXXIV').to_i).to eq(34)
    expect(RomanNumeral.new('CCLXVII').to_i).to eq(267)
    expect(RomanNumeral.new('DCCLXIV').to_i).to eq(764)
    expect(RomanNumeral.new('CMLXXXVII').to_i).to eq(987)
    expect(RomanNumeral.new('MCMLXXXIII').to_i).to eq(1983)
    expect(RomanNumeral.new('MMXIV').to_i).to eq(2014)
    expect(RomanNumeral.new('MMMM').to_i).to eq(4000)
    expect(RomanNumeral.new('MMMMCMXCIX').to_i).to eq(4999)
  end

  it "supports numbers higher than 5000" do
    expect(RomanNumeral.new("(V)").to_i).to eq(5000)
    expect(RomanNumeral.new("(V)CDLXXVIII").to_i).to eq(5478)
    expect(RomanNumeral.new("(V)M").to_i).to eq(6000)
    expect(RomanNumeral.new("(IX)").to_i).to eq(9000)
    expect(RomanNumeral.new("(X)M").to_i).to eq(11000)
    expect(RomanNumeral.new("(X)MM").to_i).to eq(12000)
    expect(RomanNumeral.new("(X)MMCCCXLV").to_i).to eq(12345)
    expect(RomanNumeral.new("(CCCX)MMMMCLIX").to_i).to eq(314159)
    expect(RomanNumeral.new("(DLXXV)MMMCCLXVII").to_i).to eq(578267)
    expect(RomanNumeral.new("(MMMCCXV)CDLXVIII").to_i).to eq(3215468)
    expect(RomanNumeral.new("(MMMMCCX)MMMMCDLXVIII").to_i).to eq(4214468)
    expect(RomanNumeral.new("(MMMMCCXV)CDLXVIII").to_i).to eq(4215468)
    expect(RomanNumeral.new("(MMMMCCXV)MMMCDLXVIII").to_i).to eq(4218468)
    expect(RomanNumeral.new("(MMMMCCXIX)CDLXVIII").to_i).to eq(4219468)

  end
  it "supports nested RomanNumerals" do
  end
end
