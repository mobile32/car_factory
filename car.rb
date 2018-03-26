require './constants'

class Car
  include CarConstants

  @@last_color = 0

  def initialize(car_brand, color_name = nil)
    @car_brand = car_brand if AVAILABLE_BRANDS.include? car_brand

    if color_name.nil?
      @color_name = AVAILABLE_COLORS[@@last_color]
      @@last_color == 2 ? @@last_color = 0 : @@last_color += 1
    elsif AVAILABLE_COLORS.include? color_name[:color]
      @color_name = color_name[:color]
    end
  end

  def brand
    to_human(@car_brand)
  end

  def color_name
    to_human(@color_name)
  end

  private

  def to_human(sym)
    text = ''
    sym.to_s.split('_').each do |word|
      text = text + word.capitalize + ' '
    end
    text.strip
  end
end
