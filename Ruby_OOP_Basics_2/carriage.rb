class Carriage

  attr_reader :type, :attached

  def initialize(type)
    @type = type
    @attached = false
  end

  def attach
    get_attached! if @attached == false
  end

  def unattach
    get_unattached! if @attached == true
  end

  def attached?
    if @attached == true
      return true
    else
  	  return false
  	end
  end
# эти методы вынесены в protected, чтобы ограничить возможность изменения параметра attached напрямую
  protected

  def get_attached!
  	@attached = true
  end

  def get_unattached!
    @attached = false
  end

end