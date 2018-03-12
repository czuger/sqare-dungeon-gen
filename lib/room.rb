class Room

  SQUARES_BETWEEN_ROOMS = 4
  ROOM_SQUARE_SIZE = 8
  SQUARE_SIZE_IN_PIXELS = 100

  def initialize( top, left )
    @top = top
    @left = left
  end

  def draw( gc )

    min_x = ( ( @left-1 ) * ROOM_SQUARE_SIZE + @left * SQUARES_BETWEEN_ROOMS ) * SQUARE_SIZE_IN_PIXELS
    max_x = min_x + ROOM_SQUARE_SIZE * SQUARE_SIZE_IN_PIXELS

    min_y = ( ( @top-1 ) * ROOM_SQUARE_SIZE + @top * SQUARES_BETWEEN_ROOMS ) * SQUARE_SIZE_IN_PIXELS
    max_y = min_y + ROOM_SQUARE_SIZE * SQUARE_SIZE_IN_PIXELS

    gc.rectangle( min_x, min_y, max_x, max_y )

  end

end