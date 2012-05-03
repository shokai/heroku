
class TmpCache
  def self.cache
    @@cache ||= Hash.new{|h,k| h = {:expire => 0, :value => nil}}
  end
  
  def self.set(key, value, expire=60)
    cache[key] = {:value => value, :expire => Time.now.to_i+expire}
    return value
  end

  def self.get(key)
    if cache[key][:expire] < Time.now.to_i
      return cache[key][:value] = nil
    else
      return cache[key][:value]
    end
  end
end


if __FILE__ == $0
  TmpCache.set('name', 'shokai', 2)
  puts TmpCache.get('name')
  sleep 3
  puts TmpCache.get('name')
end
