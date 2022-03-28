# VideoCache
module VideoCache
  def self.get(key)
    json_str = Rails.cache.read(key)
    parse_string(json_str)
  end

  def self.set(key, value)
    json_str = to_json(value)
    Rails.cache.write(key, value)
  rescue => _
    nil
  end

  def self.del(key)
    Rails.cache.delete(key)
  end

  def self.is_numeric?(str)
    true if Float(str) rescue false
  end

  def self.is_json?(str)
    begin
      !!JSON.parse(str)
    rescue
      false
    end
  end

  def self.parse_json(json_str)
    JSON.parse(json_str)
  rescue JSON::ParserError
    json_str
  end

  def self.parse_string(str)
    return parse_json(str) if is_json?(str)
    return Float(str) if is_numeric?(str)
    str
  end

  def self.to_json(value)
    return value.to_json if value.instance_of?(Hash) || value.instance_of?(Array)
    value
  end
end
