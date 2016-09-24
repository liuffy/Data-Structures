class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error #{i}" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable

  attr_reader :count, :stard_idx

  def initialize(capacity = 8)
    @capacity = capacity
    @store = StaticArray.new(capacity)
    @count = 0
    @start_idx = 0
  end

  def [](i)
    if i < 0
      i = @count + i
      return nil if i < 0
    end

    idx = @start_idx + i

    idx = idx % @capacity if idx > @capacity - 1

    @store[idx]
  end

  def []=(i, val)
    if i < 0
      index = @count + i
      unless index < 0
        @store[index] = val
      end
    else
      if i + 1 > @count
        push(nil) until @count == i
      end
      resize!
      @count += 1
      @store[i] = val
    end
    @store
  end

  def capacity
    @store.length
  end

  def include?(val)
    @count.times do |i|
      return true if self[i] == val
    end
    false
  end

  def push(val)
    resize!
    idx = @start_idx + @count

    idx = idx % @capacity if idx >= @capacity

    @store[idx] = val
    @count += 1
    self
  end

  def unshift(val)
    if @count == 0
      push(val)
    else
      if @start_idx == 0
        @start_idx = @capacity - 1
      else
        @start_idx -= 1
      end

      @store[@start_idx] = val

      @count += 1
      resize!
    end

    self
  end

  def pop
    return nil if @count < 1
    @count -= 1
    last_item = self[@count]
    @store[@count] = nil
    last_item
  end

  def shift
    return nil if @count < 1
    @count -= 1
    first_item = @store[@start_idx]

    @store[@start_idx] = nil
    @start_idx = 1
    @start_idx = 0 if @start_idx >= @capacity

    first_item
  end

  def first
    self[0]
  end

  def last
    self[@count - 1]
  end

  def each(&prc)
    @count.times do |i|
      prc.call(self[i])
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    return false unless @count == other.count

    @count.times do |i|
      return false if self[i] != other[i]
    end

    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    if @count == @capacity
      new_store = StaticArray.new(@capacity * 2)

      each_with_index do |item, idx|
        new_store[idx] = item
      end

      @store = new_store
      @capacity *= 2
      @start_idx = 0
    end
  end

end
