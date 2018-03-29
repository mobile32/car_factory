require './constants'
require './string_extensions'

class Car
  include CarConstants
  include StringExtensions

  @@number_of_cars = 0

  def initialize(car_brand, color_name = nil)
    @car_brand = car_brand if SUPPORTED_BRANDS.include? car_brand

    if color_name.nil?
      @color_name = AVAILABLE_COLORS[(@@number_of_cars) % AVAILABLE_COLORS.count]
    elsif AVAILABLE_COLORS.include? color_name[:color]
      @color_name = color_name[:color]
    end

    @@number_of_cars += 1
  end

  def brand
    to_human(@car_brand)
  end

  def color_name
    to_human(@color_name)
  end
end
