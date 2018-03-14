module DungeonDraw

  def draw( output_file )
    width = height = ( @dungeon_size * Room::ROOM_SQUARE_SIZE +
        ( ( @dungeon_size-1 ) * Room::SQUARES_BETWEEN_ROOMS ) ) * Room::SQUARE_SIZE_IN_PIXELS +
        ( Room::ROOM_SQUARE_SIZE * Room::SQUARE_SIZE_IN_PIXELS )

    create_gc( width, height )
    @rooms.each_pair do |_, r|
      r.compute_coords
      r.draw( @gc )
    end
    @hallways.draw_from_base_room @gc
    draw_gc( output_file )
  end

  def draw_current_room( output_file )
    assert_dungeon_generated
    width = height = ( Room::ROOM_SQUARE_SIZE + Room::SQUARES_BETWEEN_ROOMS * 2 ) * Room::SQUARE_SIZE_IN_PIXELS

    create_gc( width, height )
    @current_room.compute_coords_at_origin
    @current_room.draw( @gc )

    @hallways.draw_hallways_connected_to_given_room_at_origin( @gc, @current_room )

    draw_gc( output_file )
  end

  def print_dungeon( output_file )
    rooms = {}
    @rooms.each do |_, v|
      rooms[ v.room_id ] = v.to_hash( hallways )
    end
    File.open(output_file,'w') do |f|
      PP.pp(rooms,f)
    end
  end

  private

  def create_gc( width, height )
    @canvas = Magick::Image.new( width, height )

    @gc = Magick::Draw.new
    @gc.stroke( DrawableObject::GRID_COLOR )
    @gc.fill( DrawableObject::BACKGROUND_COLOR )
  end

  def draw_gc( output_file )
    @gc.draw( @canvas )
    @canvas.write( output_file )
  end

end