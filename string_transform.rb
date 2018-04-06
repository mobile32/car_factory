class StringTransform
  def self.to_human(sym)
    words = sym.to_s.split('_').map(&:capitalize).join(' ')
  end
end