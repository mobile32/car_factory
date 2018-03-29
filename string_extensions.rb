module StringExtensions
  def to_human(sym)
    words = sym.to_s.split('_').each(&:capitalize!)
    words.join(' ')
  end
end