class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash = 8543893498243789243

    each_with_index do |el, i|
      hash = hash ^ (el.hash + i).hash
    end

    hash
  end
end

class String
  def hash
    hash = 8543893498243789999

    self.chars.each_with_index do |char, i|
      hash = hash ^ (char.ord + i).hash
    end

    hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash = 8543893498243705876

    each do |key, value|
      hash = hash ^ key.hash
      hash = hash ^ value.hash
    end

    hash
  end
end
