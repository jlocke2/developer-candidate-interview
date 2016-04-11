require 'rspec'
require_relative '../tester'
require 'active_support'
require 'active_support/core_ext'


RSpec.describe Tester do
  [Tester::T1, Tester::T2, Tester::T3, Tester::T4].each do |clz|
    context 'words' do
      it 'should be a palindrome' do
        expect(clz.new.palindrome?('abcdefedcba')).to be_truthy
      end

      it 'should not be a palindrome' do
        expect(clz.new.palindrome?('hbcdefedcbg')).to be_falsey
      end
    end

    context 'phrases' do
      it 'should be a palindrome' do
        expect(clz.new.palindrome?('A man, a plan, a canal, Panama!!')).to be_truthy
      end

      it 'should not be a palindrome' do
        expect(clz.new.palindrome?(%q{
          So sorry Mrs. Fluberdeedupe -- my dog ate my homework. If I had but known
          that you were serious about collecting it today, I wouldn't have covered
          it in au jus and put it in his bowl. Next time, I'll just assume that you
          mean for us to actually do the homework and turn it in. Is there anything
          I can do to make it up to you, or to improve my grade?
          ...
          Call my parents? No, no... I don't think that's necessary. They're already
          mad at me for not making Fido eat some brocolli with it!
        })).to be_falsey
      end
    end

    context 'edge cases' do
      it 'should handle nil strings' do
        expect(clz.new.palindrome?(nil)).to be_falsey
      end

      it 'should handle empty strings' do
        expect(clz.new.palindrome?('      ')).to be_falsey
      end

      it 'should handle empty strings' do
        expect(clz.new.palindrome?('')).to be_falsey
      end

      it 'should handle non-strings (num)' do
        expect(clz.new.palindrome?(100)).to be_falsey
      end

      it 'should handle non-strings (num)' do
        expect(clz.new.palindrome?(1001)).to be_truthy
      end

      it 'should handle non-strings (array)' do
        expect(clz.new.palindrome?([1,2,3,2,1])).to be_truthy
      end

      it 'should handle non-strings (hash)' do
        expect(clz.new.palindrome?({smart: 1})).to be_falsey
      end

      it 'should handle accented characters' do
        expect(clz.new.palindrome?("Ññ")).to be_truthy
      end

      it 'should handle unicode characters (chinese)' do
        expect(clz.new.palindrome?("楚人楚")).to be_truthy
      end

      it 'should handle unicode characters (russian)' do
        expect(clz.new.palindrome?("довод")).to be_truthy
      end

      it 'should work with 3 byte unicode chars' do
        expect(clz.new.palindrome?("\u2764")).to be_truthy
      end

      it 'should work with 4 byte unicode chars' do
        expect(clz.new.palindrome?("😁")).to be_truthy
      end

    end
  end
end