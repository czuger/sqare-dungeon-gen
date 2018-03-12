require_relative 'drawable_object'

class HorizontalHallway < DrawableObject

  HALLWAY_HEIGHT=2
  HALLWAY_WIDTH=4

  def initialize( left_connected_room )
    @left_connected_room = left_connected_room
  end

  def draw( gc )

    min_x = @left_connected_room.max_x
    max_x = min_x + HALLWAY_WIDTH * SQUARE_SIZE_IN_PIXELS

    min_y = @left_connected_room.min_y + ( Room::ROOM_SQUARE_SIZE/2-1 ) * SQUARE_SIZE_IN_PIXELS
    max_y = min_y + HALLWAY_HEIGHT * SQUARE_SIZE_IN_PIXELS

    gc.rectangle( min_x, min_y, max_x, max_y )

    # Squares
    1.upto( HALLWAY_WIDTH ).each do |t|
      gc.line( min_x + SQUARE_SIZE_IN_PIXELS*t, min_y, min_x + SQUARE_SIZE_IN_PIXELS*t, max_y )
    end

    1.upto( HALLWAY_HEIGHT ).each do |t|
      gc.line( min_x, min_y + SQUARE_SIZE_IN_PIXELS*t, max_x, min_y + SQUARE_SIZE_IN_PIXELS*t )
    end


  end
end