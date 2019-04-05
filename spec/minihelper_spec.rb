require 'minihelper'

class Dummy
  extend Minihelper
end

RSpec.describe Minihelper do
  it 'has a version number' do
    expect(Minihelper::VERSION).not_to be nil
  end

  describe '.parse_money_to_float' do
    # nil string
    context 'invalid values' do
      it 'should return -1 if nil' do
        result = Dummy.parse_money_to_float(nil)
        expect(result).to eq(-1)
      end

      it 'should return -1 if a empty or white space string' do
        empty_str = Dummy.parse_money_to_float('')
        white_str = Dummy.parse_money_to_float('  ')
        expect(empty_str).to eq(-1)
        expect(white_str).to eq(-1)
      end

      it 'should return -1 if do not have numbers' do
        result = Dummy.parse_money_to_float('R$ sem numero')
        expect(result).to eq(-1)
      end
    end

    # valid string
    context 'valid value' do
      context 'simple ","(comma)' do
        it 'should return 10.0 if R$10,00' do
          result = Dummy.parse_money_to_float('R$10,00')
          expect(result).to eq(10.0)
        end

        it 'should return 10.00 if 10,00 (value without R$)' do
          result = Dummy.parse_money_to_float('10,00')
          expect(result).to eq(10.0)
        end
      end
      context 'simple "."(point)' do
        it 'should return 10.0 if R$10.00' do
          result = Dummy.parse_money_to_float('R$10.00')
          expect(result).to eq(10.0)
        end

        it 'should return 10.00 if 10,00 (value without R$)' do
          result = Dummy.parse_money_to_float('10.00')
          expect(result).to eq(10.0)
        end
      end

      context 'whith decimal part' do
        it 'should return 100.01 if R$100,01 (comma cents separator)' do
          result = Dummy.parse_money_to_float('R$100,01')
          expect(result).to eq(100.01)
        end

        it 'should return 100.01 if R$100.01 (point cents separator)' do
          result = Dummy.parse_money_to_float('R$100.01')
          expect(result).to eq(100.01)
        end
      end

      context 'with thousand separator' do
        it 'should return 1000.0 if money R$1,000 (comma thousand separator)' do
          result = Dummy.parse_money_to_float('R$1,000')
          expect(result).to eq(1000.0)
        end

        it 'should return 1000.0 if money R$1.000 (point thousand separator)' do
          result = Dummy.parse_money_to_float('R$1.000')
          expect(result).to eq(1000.0)
        end

        it 'should return 27800.0 if money 27,800' do
          result = Dummy.parse_money_to_float('27,800')
          expect(result).to eq(27_800.0)
        end
      end

      context 'complex values' do
        it 'should return 1000.15 if money R$1,000,15' do
          result = Dummy.parse_money_to_float('R$1,000,15')
          expect(result).to eq(1000.15)
        end

        it 'should return 1_000_122.15 if money R$1,000.122,15' do
          result = Dummy.parse_money_to_float('R$1,000.122,15')
          expect(result).to eq(1_000_122.15)
        end

        it 'should return 1_000_000 if money R$1,000,000' do
          result = Dummy.parse_money_to_float('R$1,000,000')
          expect(result).to eq(1_000_000.0)
        end

        it 'should return 10 if money R$10' do
          result = Dummy.parse_money_to_float('R$10')
          expect(result).to eq(10.0)
        end

        it 'should return 1.1 if money R$1.1' do
          result = Dummy.parse_money_to_float('R$1.1')
          expect(result).to eq(1.1)
        end

        it 'should return 1.1123 if money 1,1123' do
          result = Dummy.parse_money_to_float('1,1123')
          expect(result).to eq(1.1123)
        end
      end

      # complex values
    end
  end
end
