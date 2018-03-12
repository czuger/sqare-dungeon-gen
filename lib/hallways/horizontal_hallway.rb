require_relative 'hallway'

class HorizontalHallway < Hallway

  HALLWAY_HEIGHT=2
  HALLWAY_WIDTH=4

  def draw( gc, base_room )
    min_x = base_room.max_x
    max_x = min_x + HALLWAY_WIDTH * SQUARE_SIZE_IN_PIXELS

    min_y = base_room.min_y + ( Room::ROOM_SQUARE_SIZE/2-1 ) * SQUARE_SIZE_IN_PIXELS
    max_y = min_y + HALLWAY_HEIGHT * SQUARE_SIZE_IN_PIXELS

    super( gc, HALLWAY_WIDTH, HALLWAY_HEIGHT, min_x, max_x, min_y, max_y )
  end

  def draw_from_base_room( gc )
    draw( gc, @draw_base_room )
  end

end