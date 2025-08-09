require_relative 'linkedlist.rb'
class HashMap
  attr_accessor :capacity, :load_factor, :hash_map, :used_space

  def initialize
    @capacity = 16
    @load_factor = 0.75
    @used_space = 0
    @hash_map = Array.new(self.capacity){LinkedList.new} 
  end

  def hash(key)
    hash_code = 0
    prime_number = 101
    mod = 2**64
  
    key.each_char { |char| hash_code = (prime_number * hash_code + char.ord) % mod }
  
    hash_code
  end
  

  def set(key, value)
    if self.used_space / self.capacity > self.load_factor
      self.capacity *= 2
      updated_hash_map = Array.new(self.capacity){LinkedList.new}
      self.hash_map.each_with_index { |element, idx| updated_hash_map[idx] = element }
      self.hash_map = updated_hash_map
    end

    hashed_key = hash(key) % self.capacity
    self.used_space += 1 if self.hash_map[hashed_key].head.nil?
    self.hash_map[hashed_key].append(value)
  end

  def get(key)
    hashed_key = self.hash(key) % self.capacity
    if !self.hash_map[hashed_key].head.nil?
      return self.hash_map[hashed_key]
    end
    return nil
  end

  def has?(key)
    hashed_key = self.hash(key) % self.capacity
    if !self.hash_map[hashed_key].head.nil?
      return true
    end
    return false
  end

  def remove(key)
    if self.has?(key)
      hashed_key = self.hash(key) % self.capacity
      value = self.hash_map[hashed_key]
      self.hash_map[hashed_key].head = nil
      return value
    end
    return nil
  end

  def length
    count = 0
    for i in self.hash_map.length
      if !self.hash_map[i].head.nil?
        count += 1
      end
    end
    return count
  end

  def clear
    self.hash_map = Array.new(self.capacity){LinkedList.new} 
  end

  def entries
    entries_arr = []
    self.hash_map.each_with_index do |element, idx|
      if !element.head.value.nil?
        tmp_arr = [idx, element.head.value]
        entries_arr.append(tmp_arr)
      end
    end
    return entries_arr
  end
end