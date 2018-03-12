require_relative 'drawable_object'

class Room < DrawableObject

  SQUARES_BETWEEN_ROOMS = 4
  ROOM_SQUARE_SIZE = 8

  def initialize( top, left )
    @top = top
    @left = left
    @connected_hallways = []
  end

  def min_x
    ( ( @left-1 ) * ROOM_SQUARE_SIZE + @left * SQUARES_BETWEEN_ROOMS ) * SQUARE_SIZE_IN_PIXELS
  end

  def max_x
    min_x + ROOM_SQUARE_SIZE * SQUARE_SIZE_IN_PIXELS
  end

  def min_y
    ( ( @top-1 ) * ROOM_SQUARE_SIZE + @top * SQUARES_BETWEEN_ROOMS ) * SQUARE_SIZE_IN_PIXELS
  end

  def max_y
    min_y + ROOM_SQUARE_SIZE * SQUARE_SIZE_IN_PIXELS
  end

  def top_left_array
    [ @top, @left ]
  end

  def connect_hallways( hallways )
    @connected_hallways << hallways
  end

  def disable_hallways
    @connected_hallways.each{ |h| h.disable }
  end

  def draw( gc )

    gc.rectangle( min_x, min_y, max_x, max_y )

    # Squares
    1.upto( ROOM_SQUARE_SIZE ).each do |t|
      gc.line( min_x + SQUARE_SIZE_IN_PIXELS*t, min_y, min_x + SQUARE_SIZE_IN_PIXELS*t, max_y )
      gc.line( min_x, min_y + SQUARE_SIZE_IN_PIXELS*t, max_x, min_y + SQUARE_SIZE_IN_PIXELS*t )
    end

  end

end