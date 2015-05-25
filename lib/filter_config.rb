class FilterConfig

  def self.add(root_label,config_array)
    @c ||= {}
    @c[root_label] = config_array
  end

  def self.add_phrases(phrases)
    @phrases = phrases
  end

  def self.phrases
    @phrases
  end

  def self.configs
    @c
  end
end
