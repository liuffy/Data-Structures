require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def set(key,val)
    if include?(key)
      @store[get_index(key)].get_link(key).val = val
    else
      @count += 1
      resize! if @count > num_buckets
      @store[get_index(key)].insert(key,val)
    end
  end

  def delete(key)
    @count -= 1
    @store[get_index(key)].remove(key)
  end

  def get(key)
    @store[get_index(key)].get(key)
  end

  def include?(key)
    @store[get_index(key)].include?(key)
  end

  def each(&prc)
    @store.each do |bucket|
      bucket.each do |link|
        prc.call(link.key,link.val)
      end
    end
  end


  def [](key)
    get(key)
  end

  def []=(key,val)
    set(key,val)
  end

  private

  def get_index(key)
    key.hash % num_buckets
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_buckets = num_buckets * 2
    new_store = Array.new(new_buckets) { LinkedList.new }
    each do |key,val|
      new_index = key.hash % new_buckets
      new_store[new_index].insert(key,val)
    end
    @store = new_store
  end
end
