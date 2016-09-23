class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  attr_accessor  :head, :tail
  include Enumerable


  def initialize
    set_sentinels
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first(include_head = false)
    if include_head
      return @head
    else
      return @head.next
    end
    nil
  end

  def last(include_tail = false)
    if include_tail
      return @tail
    else
      return @tail.prev
    end
    nil
  end

  def empty?
    first.val.nil? && last.val.nil?
  end

  def get(key)
    link = get_link(key)

    return nil unless link
    link.val
  end

  def include?(key)
    get_link(key) != nil
  end

  def insert(key, val)
    link = Link.new(key,val)
    link.next = @tail
    link.prev = @tail.prev
    @tail.prev.next = link
    @tail.prev = link
    link
  end

  def remove(key)
    link = get_link(key)

    unless link.nil?
      link.prev.next = link.next
      link.next.prev = link.prev
    end
    link
  end

  def each(&prc)
    link = @head

    until link == @tail
      unless link == @head
        prc.call(link)
      end
      link = link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end

  def get_link(key)
    each do |link|
      return link if link.key == key
    end

    nil
  end

  private

  def set_sentinels
    @head = Link.new(:head,nil)
    @tail = Link.new(:tail,nil)
    @head.next = @tail
    @tail.prev = @head
  end

end
