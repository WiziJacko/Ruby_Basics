require_relative 'company'

class Carriage

  include Company

  attr_reader :attached

  def initialize
    @attached = false
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

end
