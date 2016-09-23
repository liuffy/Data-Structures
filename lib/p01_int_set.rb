class MaxIntSet
  def initialize(max)
    @set = Array.new(max, false)
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @set[num] = true
  end

  def remove(num)
    @set[num] = false
  end

  def include?(num)
    @set[num]
  end

  private

  def is_valid?(num)
    num.between?(0,@set.length-1)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    idx = get_index(num)
    @store[idx] << num unless include?(num)
  end

  def remove(num)
    idx = get_index(num)
    @store[idx].delete(num)
  end

  def include?(num)
    idx = get_index(num)
    @store[idx].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def get_index(num)
    num % num_buckets
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    @count += 1
    resize! if @count > num_buckets
    @store[get_index(num)] << num
  end

  def remove(num)
    @count -= 1
    @store[get_index(num)].delete(num)
  end

  def include?(num)
    @store[get_index(num)].include?(num)
  end

  def each(&prc)
    @store.each do |bucket|
      bucket.each do |num|
        prc.call(num)
      end
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_buckets = num_buckets*2
    new_store = Array.new(new_buckets) { Array.new }
    each do |num|
      new_index = num % new_buckets
      new_store[new_index] << num
    end
    @store = new_store
  end

  def get_index(num)
    num % num_buckets
  end
end
