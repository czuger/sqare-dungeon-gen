require_relative 'hallway'

class HorizontalHallway < Hallway

  HALLWAY_HEIGHT=2
  HALLWAY_WIDTH=4

  def set_input_room( room )
    @rooms[ :left ] = room
    room.connect_hallway( :left, self )
  end

  def set_output_room( room )
    @rooms[ :right ] = room
    room.connect_hallway( :right, self )
  end

  def connected_room( direction )
    if direction == :left
      return @rooms[:right]
    else
      return @rooms[:left]
    end
  end

  def in_room_connection
    :right
  end

  def out_room_connection
    :left
  end

  def draw( gc, base_room, x_decal = 0 )
    min_x = base_room.max_x - x_decal
    max_x = min_x + HALLWAY_WIDTH * SQUARE_SIZE_IN_PIXELS - x_decal

    min_y = base_room.min_y + ( Room::ROOM_SQUARE_SIZE/2-1 ) * SQUARE_SIZE_IN_PIXELS
    max_y = min_y + HALLWAY_HEIGHT * SQUARE_SIZE_IN_PIXELS

    super( gc, HALLWAY_WIDTH, HALLWAY_HEIGHT, min_x, max_x, min_y, max_y, x_decal: x_decal/2 )
  end

  def draw_from_base_room( gc )
    draw( gc, @draw_base_room )
  end

  def draw_out_from_given_room( gc, room )
    draw( gc, room )
  end

  def draw_in_from_given_room( gc, room )
    draw( gc, room, ( Room::ROOM_SQUARE_SIZE ) * SQUARE_SIZE_IN_PIXELS )
  end

end