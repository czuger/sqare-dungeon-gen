require_relative 'room'
require_relative 'horizontal_hallway'
require_relative 'vertical_hallway'
require 'rmagick'

class Dungeon

  def initialize( dungeon_size )
    @dungeon_size = dungeon_size
    @rooms = {}
    @hallways = []

    create_dungeon
    connect_hallways

    @rooms[ [ 2, 2 ] ].disable_hallways
    @rooms.delete( [ 2, 2 ] )
  end

  def create_dungeon
    1.upto(@dungeon_size) do |top|
      1.upto(@dungeon_size) do |left|
        @rooms[ [ top, left ] ] = Room.new( top, left )
      end
    end
  end

  def connect_hallways
    1.upto(@dungeon_size) do |top|
      1.upto(@dungeon_size) do |left|
        @hallways << HorizontalHallway.new( @rooms[ [ top, left ] ], @rooms[ [ top, left+1 ] ] ) unless left == @dungeon_size
        @hallways << VerticalHallway.new( @rooms[ [ top, left ] ], @rooms[ [ top+1, left ] ] ) unless top == @dungeon_size
      end
    end
  end

  def draw
    width = height = ( @dungeon_size * Room::ROOM_SQUARE_SIZE +
        ( ( @dungeon_size-1 ) * Room::SQUARES_BETWEEN_ROOMS ) ) * Room::SQUARE_SIZE_IN_PIXELS +
        ( Room::ROOM_SQUARE_SIZE * Room::SQUARE_SIZE_IN_PIXELS )

    canvas = Magick::Image.new( width, height )

    gc = Magick::Draw.new
    gc.stroke( 'darkslateblue' )
    gc.fill( 'white' )

    @rooms.each_pair{ |_, r| r.draw( gc ) }
    @hallways.each{ |h| h.draw( gc ) unless h.disabled }

    gc.draw( canvas )
    canvas.write( 'out/dungeon.jpg' )

  end

end

Dungeon.new( 3 ).draw