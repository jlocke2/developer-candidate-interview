class Tester
  class T1
    def palindrome?(string)      
      # since to_s is defind in Object it should work on anything (as long as it inherits from Object)
      # converts nil to "" which works perfectly for us
      # based on tests we want to remove anything that isn't alphanumeric
      # gsub! returns nil, if no substitutions. we don't want this, so we use gsub
      # could also user \W or ^[:alnum:] in gsub (ok there's a lot of different ways actually)
      # tests indicate not case sensitive. hence the downcase method
      string = string.to_s.mb_chars.gsub(/[[:punct:][:space:]]+/, '').downcase
      return false if string.empty?

      # could also use eql? or ===
      # == seems most idiomatic
      string == string.reverse
    end
  end

  class T2
    def palindrome?(string)
      # trying something a little different
      # let's forget strings and just compare arrays
      letters = string.to_s.mb_chars.downcase.scan(/[^[:punct:]^[:space:]]/)
      return false if letters.empty?

      letters == letters.reverse
    end
  end

  class T3
    def palindrome?(string)
      letters = string.to_s.mb_chars.downcase.scan(/[^[:punct:]^[:space:]]/)
      return false if letters.empty?

      letters.each do |letter|
        return false unless letter == letters.pop
      end

      true
    end
  end

  class T4
    def palindrome?(string)
      letters = string.to_s.mb_chars.downcase.scan(/[^[:punct:]^[:space:]]/)
      return false if letters.empty? # this should only apply the first time through the function

      return true if letters.length == 1

      return false unless letters.shift == letters.pop

      return true if letters.empty?

      palindrome?(letters)
    end
  end
end
