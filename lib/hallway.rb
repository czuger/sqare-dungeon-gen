require_relative 'drawable_object'

class Hallway < DrawableObject

  attr_reader :disabled

  def disable
    @disabled = true
  end

  def connect_to_rooms( r1, r2 )
    r1.connect_hallways( self )
    r2.connect_hallways( self )
  end

end