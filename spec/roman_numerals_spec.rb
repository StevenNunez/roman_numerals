require 'spec_helper'

describe RomanNumeralConverter do
  it "converts single letters to decimal equivalent" do
    expect(RomanNumeralConverter.new('I').to_i).to eq(1)
    expect(RomanNumeralConverter.new('V').to_i).to eq(5)
    expect(RomanNumeralConverter.new('X').to_i).to eq(10)
    expect(RomanNumeralConverter.new('L').to_i).to eq(50)
    expect(RomanNumeralConverter.new('C').to_i).to eq(100)
    expect(RomanNumeralConverter.new('D').to_i).to eq(500)
    expect(RomanNumeralConverter.new('M').to_i).to eq(1000)
  end

  it "does additive math" do
    expect(RomanNumeralConverter.new('II').to_i).to eq(2)
    expect(RomanNumeralConverter.new('MDCLXVI').to_i).to eq(1666)
  end

  it "does subtractive math" do
    expect(RomanNumeralConverter.new('IV').to_i).to eq(4)
    expect(RomanNumeralConverter.new('IX').to_i).to eq(9)
    expect(RomanNumeralConverter.new('XL').to_i).to eq(40)
    expect(RomanNumeralConverter.new('XC').to_i).to eq(90)
    expect(RomanNumeralConverter.new('CD').to_i).to eq(400)
    expect(RomanNumeralConverter.new('CM').to_i).to eq(900)
  end

  it "passes these random tests" do
    expect(RomanNumeralConverter.new('IV').to_i).to eq(4)
    expect(RomanNumeralConverter.new('XXXIV').to_i).to eq(34)
    expect(RomanNumeralConverter.new('CCLXVII').to_i).to eq(267)
    expect(RomanNumeralConverter.new('DCCLXIV').to_i).to eq(764)
    expect(RomanNumeralConverter.new('CMLXXXVII').to_i).to eq(987)
    expect(RomanNumeralConverter.new('MCMLXXXIII').to_i).to eq(1983)
    expect(RomanNumeralConverter.new('MMXIV').to_i).to eq(2014)
    expect(RomanNumeralConverter.new('MMMM').to_i).to eq(4000)
    expect(RomanNumeralConverter.new('MMMMCMXCIX').to_i).to eq(4999)
  end

  it "supports numbers higher than 5000" do
    expect(RomanNumeralConverter.new("(V)").to_i).to eq(5000)
    expect(RomanNumeralConverter.new("(V)CDLXXVIII").to_i).to eq(5478)
    expect(RomanNumeralConverter.new("(V)M").to_i).to eq(6000)
    expect(RomanNumeralConverter.new("(IX)").to_i).to eq(9000)
    expect(RomanNumeralConverter.new("(X)M").to_i).to eq(11000)
    expect(RomanNumeralConverter.new("(X)MM").to_i).to eq(12000)
    expect(RomanNumeralConverter.new("(X)MMCCCXLV").to_i).to eq(12345)
    expect(RomanNumeralConverter.new("(CCCX)MMMMCLIX").to_i).to eq(314159)
    expect(RomanNumeralConverter.new("(DLXXV)MMMCCLXVII").to_i).to eq(578267)
    expect(RomanNumeralConverter.new("(MMMCCXV)CDLXVIII").to_i).to eq(3215468)
    expect(RomanNumeralConverter.new("(MMMMCCX)MMMMCDLXVIII").to_i).to eq(4214468)
    expect(RomanNumeralConverter.new("(MMMMCCXV)CDLXVIII").to_i).to eq(4215468)
    expect(RomanNumeralConverter.new("(MMMMCCXV)MMMCDLXVIII").to_i).to eq(4218468)
    expect(RomanNumeralConverter.new("(MMMMCCXIX)CDLXVIII").to_i).to eq(4219468)

  end
  it "supports nested RomanNumeralConverters" do
    expect(RomanNumeralConverter.new("((XV)MDCCLXXV)MMCCXVI").to_i).to eq(16777216)
    expect(RomanNumeralConverter.new("((CCCX)MMMMCLIX)CCLXV").to_i).to eq(314159265)
    expect(RomanNumeralConverter.new("((MLXX)MMMDCCXL)MDCCCXXIV").to_i).to eq(1073741824)
  end
end
