require_relative 'company'

class Carriage

  include Company

  attr_reader :attached, :all_space, :occupied_spaces

  def initialize(space)
    @attached = false
    @all_spaces = space
    @occupied_spaces = 0
  end

  def attach!
    @attached = true if !attached?
  end

  def detach!
    @attached = false if attached?
  end

  def attached?
    @attached
  end

  def take_up_space(space)
    return if available_spaces.zero?
    return @occupied_spaces = @all_spaces if available_spaces < space
    @occupied_spaces += space
  end

  def available_spaces
    @all_spaces - @occupied_spaces
  end

end
