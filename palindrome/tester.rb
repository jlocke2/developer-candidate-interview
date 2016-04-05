class Tester
  class T1
    def palindrome?(string)      
      # since to_s is defind in Object it should work on anything (as long as it inherits from Object)
      # converts nil to "" which works perfectly for us
      # based on tests we want to remove anything that isn't alphanumeric
      # gsub! returns nil, if no substitutions. we don't want this, so we use gsub
      # could also user \W or ^[:alnum:] in gsub (ok there's a lot of different ways actually)
      # tests indicate not case sensitive. hence the downcase method
      string = string.to_s.gsub(/[^A-Za-z0-9]+/, '').downcase
      return if string.empty?

      # could also use eql? or ===
      # == seems most idiomatic
      string == string.reverse
    end
  end

  class T2
    def palindrome?(string)
      # trying something a little different
      # let's forget strings and just compare arrays
      letters = string.to_s.downcase.scan(/\w/)
      return if letters.empty?

      letters == letters.reverse
    end
  end
end
