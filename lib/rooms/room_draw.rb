module RoomDraw

  def draw( gc )
    gc.rectangle( @min_x, @min_y, @max_x, @max_y )

    # Squares
    1.upto( Room::ROOM_SQUARE_SIZE ).each do |t|
      gc.line( @min_x + DrawableObject::SQUARE_SIZE_IN_PIXELS*t, @min_y, @min_x + DrawableObject::SQUARE_SIZE_IN_PIXELS*t, @max_y )
      gc.line( @min_x, @min_y + DrawableObject::SQUARE_SIZE_IN_PIXELS*t, @max_x, @min_y + DrawableObject::SQUARE_SIZE_IN_PIXELS*t )
    end

    if @content
      print_text( gc, @content )
    end

    @decorations.each do |decoration|
      draw_four_columns(gc, decoration[:decoration_data] ) if decoration[:decoration_type] == :four_columns
    end
  end

  private

  def print_text( gc, text )
    x = @min_x + (Room::ROOM_SQUARE_SIZE/2.35) * DrawableObject::SQUARE_SIZE_IN_PIXELS
    y = @min_y + (Room::ROOM_SQUARE_SIZE/1.73) * DrawableObject::SQUARE_SIZE_IN_PIXELS
    gc.pointsize( (Room::ROOM_SQUARE_SIZE*100)/8 )
    gc.fill( DrawableObject::TEXT_COLOR )
    gc.text( x, y, text )
    gc.fill( DrawableObject::BACKGROUND_COLOR )
  end

  def draw_four_columns(gc, columns_data )
    gc.stroke( DrawableObject::GRID_COLOR )
    gc.fill( DrawableObject::GRID_COLOR )

    columns_data.each do |c_data|
      min_x = (c_data[:left]+1)*DrawableObject::SQUARE_SIZE_IN_PIXELS + @min_x
      min_y = (c_data[:top]+1)*DrawableObject::SQUARE_SIZE_IN_PIXELS + @min_y
      perim_x = min_x+3
      perim_y = min_y - DrawableObject::SQUARE_SIZE_IN_PIXELS+3

      gc.circle( min_x, min_y, perim_x, perim_y )
    end
    gc.fill( DrawableObject::BACKGROUND_COLOR )
  end

end