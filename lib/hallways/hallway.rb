require_relative '../drawable_object'

class Hallway < DrawableObject

  attr_reader :disabled

  attr_reader :rooms

  def initialize
    @rooms = {}
  end

  def disable!
    @disabled = true
  end

  def set_draw_base_room( draw_base_room )
    @draw_base_room = draw_base_room
  end

  private

  def draw( gc, width, height, min_x, max_x, min_y, max_y, x_decal: 0, y_decal: 0 )
    gc.rectangle( min_x, min_y, max_x, max_y )

    # Squares
    1.upto( width ).each do |t|
      gc.line( min_x + SQUARE_SIZE_IN_PIXELS*t - x_decal, min_y, min_x + SQUARE_SIZE_IN_PIXELS*t - x_decal, max_y )
    end

    1.upto( height ).each do |t|
      gc.line( min_x, min_y + SQUARE_SIZE_IN_PIXELS*t - y_decal, max_x, min_y + SQUARE_SIZE_IN_PIXELS*t - y_decal )
    end
  end

end