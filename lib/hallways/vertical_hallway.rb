require_relative 'hallway'

class VerticalHallway < Hallway

  HALLWAY_HEIGHT=4
  HALLWAY_WIDTH=2

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

  def draw_top_from_given_room( gc, room )
    # Le problème vient du decal. Si je supprime HALLWAY_HEIGHT, j'ai les lignes horizontales et pas les verticales.
    draw( gc, room, ( Room::ROOM_SQUARE_SIZE ) * SQUARE_SIZE_IN_PIXELS )
  end

  def draw_bottom_from_given_room( gc, room )
    draw( gc, room )
  end

end