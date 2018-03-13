require_relative 'hallway'

class VerticalHallway < Hallway

  HALLWAY_HEIGHT=4
  HALLWAY_WIDTH=2

  def set_input_room( room )
    @rooms[ :top ] = room
    room.connect_hallway( :top, self )
  end

  def set_output_room( room )
    @rooms[ :bottom ] = room
    room.connect_hallway( :bottom, self )
  end

  def connected_room( direction )
    if direction == :top
      return @rooms[:bottom]
    else
      return @rooms[:top]
    end
  end

  def in_room_connection
    :bottom
  end

  def out_room_connection
    :top
  end

  def draw( gc, base_room, y_decal = 0 )
    min_x = base_room.min_x + ( Room::ROOM_SQUARE_SIZE/2-1 ) * SQUARE_SIZE_IN_PIXELS
    max_x = min_x + HALLWAY_WIDTH * SQUARE_SIZE_IN_PIXELS

    min_y = base_room.max_y - y_decal
    max_y = min_y + HALLWAY_HEIGHT * SQUARE_SIZE_IN_PIXELS - y_decal

    super( gc, HALLWAY_WIDTH, HALLWAY_HEIGHT, min_x, max_x, min_y, max_y, y_decal: y_decal/2 )
  end

  def draw_from_base_room( gc )
    draw( gc, @draw_base_room )
  end

  def draw_out_from_given_room( gc, room )
    draw( gc, room )
  end

  def draw_in_from_given_room( gc, room )
    # Le problème vient du decal. Si je supprime HALLWAY_HEIGHT, j'ai les lignes horizontales et pas les verticales.
    draw( gc, room, ( Room::ROOM_SQUARE_SIZE ) * SQUARE_SIZE_IN_PIXELS )
  end

end