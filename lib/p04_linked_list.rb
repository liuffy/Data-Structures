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
  include Enumerable

  def initialize
    set_sentinels
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    return @head.next unless @head.next.key == :tail
    nil
  end

  def last
    return @tail.prev unless @tail.prev.key == :head
    nil
  end

  def empty?
    first.nil? && last.nil?
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
  end

  def remove(key)
    link = get_link(key)

    unless link.nil?
      link.prev.next = link.next
      link.next.prev = link.prev
    end
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

  private

  def set_sentinels
    @head = Link.new(:head,nil)
    @tail = Link.new(:tail,nil)
    @head.next = @tail
    @tail.prev = @head
  end

  def get_link(key)
    each do |link|
      return link if link.key == key
    end

    nil
  end

end
