require_relative 'hallway'

class VerticalHallway < Hallway

  HALLWAY_HEIGHT=4
  HALLWAY_WIDTH=2

  def draw( gc )
    min_x = @draw_base_room.min_x + ( Room::ROOM_SQUARE_SIZE/2-1 ) * SQUARE_SIZE_IN_PIXELS
    max_x = min_x + HALLWAY_WIDTH * SQUARE_SIZE_IN_PIXELS

    min_y = @draw_base_room.max_y
    max_y = min_y + HALLWAY_HEIGHT * SQUARE_SIZE_IN_PIXELS

    super( gc, HALLWAY_WIDTH, HALLWAY_HEIGHT, min_x, max_x, min_y, max_y )
  end
end