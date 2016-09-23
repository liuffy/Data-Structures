require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      link = @map[key]
      update_link!(link)
      link.val
    else
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    value = @prc.call(key)
    link = @store.insert(key,value)
    @map[key] = link
    eject!
    value
  end

  def update_link!(link)
    link.prev.next = link.next
    link.next.prev = link.prev
    link.prev = @store.last
    link.next = @store.first
  end

  def eject!
    if count > @max
      link = @store.first
      link.next.prev = @store.head unless link.next.nil?
      @store.head.next = link.next
      @map.delete(link.key)
    end
  end

end


#def get(key)
# @store[get_index(key)].include?(key)
#end
