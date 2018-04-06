require './string_extensions'

class Car
  include StringExtensions

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

  attr_reader :car_brand, :color_name

  def initialize(car_brand, color_name = nil)
    @car_brand = car_brand if SUPPORTED_BRANDS.include? car_brand

    if color_name.nil?
      @color_name = AVAILABLE_COLORS[self.class.number_of_cars % AVAILABLE_COLORS.count]
    elsif AVAILABLE_COLORS.include? color_name[:color]
      @color_name = color_name[:color]
    end

    self.class.number_of_cars += 1
  end

  def brand
    to_human(car_brand)
  end

  def color_name
    to_human(color_name)
  end
end



