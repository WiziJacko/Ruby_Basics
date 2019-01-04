require_relative 'company'

class Carriage
  include Company

  ZERO_ERROR = 'Нет свободного пространства'.freeze
  OVER_SPACE_ERROR = 'Доступно меньше пространства'.freeze

  attr_reader :attached, :all_space, :occupied_spaces

  def initialize(space)
    @attached = false
    @all_spaces = space
    @occupied_spaces = 0
  end

  def attach!
    @attached = true unless attached?
  end

  def detach!
    @attached = false if attached?
  end

  def attached?
    @attached
  end

  def take_up_space(space)
    raise ZERO_ERROR if available_spaces.zero?
    raise OVER_SPACE_ERROR if available_spaces < space

    @occupied_spaces += space
  end

  def available_spaces
    @all_spaces - @occupied_spaces
  end
end
