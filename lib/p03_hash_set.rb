require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    @count += 1
    resize! if @count > num_buckets
    @store[get_index(key)] << key
  end


  def remove(key)
    @count -= 1
    @store[get_index(key)].delete(key)
  end

  def include?(key)
    @store[get_index(key)].include?(key)
  end

  def each(&prc)
    @store.each do |bucket|
      bucket.each do |key|
        prc.call(key)
      end
    end
  end

  private

  def get_index(key)
    key.hash % num_buckets
  end

  def [](num)
    @store[num]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_buckets = num_buckets * 2
    new_store = Array.new(new_buckets) { Array.new }
    each do |key|
      new_index = key.hash % new_buckets
      new_store[new_index] << key
    end
    @store = new_store
  end
end
