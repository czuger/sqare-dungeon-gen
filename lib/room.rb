require_relative 'drawable_object'
require_relative 'hallways/hallway'
require 'hazard'

class Room < DrawableObject

  SQUARES_BETWEEN_ROOMS = Hallway::HALLWAYS_LENGTH
  ROOM_SQUARE_SIZE = 12

  attr_reader :top, :left, :entry_room, :min_x, :min_y, :max_x, :max_y
  attr_accessor :room_id

  def initialize( top, left )
    @top = top
    @left = left
    fill_room
  end

  def top_left_array
    [ @top, @left ]
  end

  def set_entry_room
    @entry_room = true
    @content = 'E'
  end

  def set_treasure_room
    @content = 'H'
  end

  def decal_at_origin
    @top = 1
    @left = 1
  end

  def compute_coords
    @min_x = ( ( @left-1 ) * ROOM_SQUARE_SIZE + @left * SQUARES_BETWEEN_ROOMS ) * SQUARE_SIZE_IN_PIXELS
    @max_x = @min_x + ROOM_SQUARE_SIZE * SQUARE_SIZE_IN_PIXELS
    @min_y = ( ( @top-1 ) * ROOM_SQUARE_SIZE + @top * SQUARES_BETWEEN_ROOMS ) * SQUARE_SIZE_IN_PIXELS
    @max_y = @min_y + ROOM_SQUARE_SIZE * SQUARE_SIZE_IN_PIXELS
  end

  def compute_coords_at_origin
    @min_x = SQUARES_BETWEEN_ROOMS * SQUARE_SIZE_IN_PIXELS
    @max_x = @min_x + ROOM_SQUARE_SIZE * SQUARE_SIZE_IN_PIXELS
    @min_y = SQUARES_BETWEEN_ROOMS * SQUARE_SIZE_IN_PIXELS
    @max_y = @min_y + ROOM_SQUARE_SIZE * SQUARE_SIZE_IN_PIXELS
  end

  def draw( gc )
    gc.rectangle( @min_x, @min_y, @max_x, @max_y )

    # Squares
    1.upto( ROOM_SQUARE_SIZE ).each do |t|
      gc.line( @min_x + SQUARE_SIZE_IN_PIXELS*t, @min_y, @min_x + SQUARE_SIZE_IN_PIXELS*t, @max_y )
      gc.line( @min_x, @min_y + SQUARE_SIZE_IN_PIXELS*t, @max_x, @min_y + SQUARE_SIZE_IN_PIXELS*t )
    end

    if @content
      print_text( gc, @content )
    end

  end

  def to_hash( hallways )
    { room_id: @room_id, entry_room: @entry_room, content: @content, top: @top, left: @left,
      connected_hallways: hallways.connected_hallways( self ).map{ |k, h| { k => h.to_hash } } }
  end

  def to_json_hash( hallways )
    h = to_hash( hallways )
    h.delete(:connected_hallways)
    h
  end

  def from_json( room_data )
    @room_id = room_data['room_id']
    @entry_room = room_data['entry_room']
    @content = room_data['content']
    @top = room_data['top'].to_i
    @left = room_data['left'].to_i
    self
  end

  private

  def fill_room
    roll = Hazard.d6
    @content = 'T' if roll == 1
    @content = 'M' if roll > 1 && roll < 6
  end

  def print_text( gc, text )
    x = @min_x + (ROOM_SQUARE_SIZE/3) * SQUARE_SIZE_IN_PIXELS
    y = @min_y + (ROOM_SQUARE_SIZE/3) * SQUARE_SIZE_IN_PIXELS
    gc.pointsize( 100 )
    gc.fill( 'black' )
    # puts text.join( '' ).inspect
    gc.text( x, y, text )
    gc.fill( 'white' )
  end

end