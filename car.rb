require './string_transform'

class Car
  class << self
    attr_accessor :number_of_cars
  end
  self.number_of_cars = 0

  SUPPORTED_BRANDS = %i[
    fiat
    lancia
    ford
    subaru
  ].freeze

  AVAILABLE_COLORS = %i[
    black
    red
    yellow
    navy_blue
  ].freeze

  attr_reader :car_brand, :color_value

  def initialize(car_brand, color: nil)
    @car_brand = car_brand if SUPPORTED_BRANDS.include? car_brand

    if color.nil?
      @color_value = AVAILABLE_COLORS[self.class.number_of_cars % AVAILABLE_COLORS.count]
    elsif AVAILABLE_COLORS.include? color
      @color_value = color
    end

    self.class.number_of_cars += 1
  end

  def brand
    StringTransform.to_human(car_brand)
  end

  def color_name
    StringTransform.to_human(color_value)
  end
end

