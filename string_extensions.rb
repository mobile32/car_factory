module StringExtensions
  def to_human(sym)
    text = ''
    sym.to_s.split('_').each do |word|
      text = text + word.capitalize + ' '
    end
    text.strip
  end
end