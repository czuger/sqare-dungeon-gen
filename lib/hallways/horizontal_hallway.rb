require_relative 'hallway'

class HorizontalHallway < Hallway

  HALLWAY_HEIGHT=2
  HALLWAY_WIDTH=4

  def get_direction_array( rooms_keys, room )
    return [ nil, nil ] if disabled
    return [ :right, self ] if rooms_keys[0] == room.top_left_array
    return [ :left, self ] if rooms_keys[1] == room.top_left_array
    [ nil, nil ]
  end

  def get_connected_room( direction )
    if direction == :right
      @hallway_id[1]
    else
      @hallway_id[0]
    end
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

  def draw_from_given_room( gc, room, direction )
    if direction == :right
      draw( gc, room )
    else
      draw( gc, room, ( Room::ROOM_SQUARE_SIZE ) * SQUARE_SIZE_IN_PIXELS )
    end
  end

end