require_relative 'room'
require_relative 'horizontal_hallway'
require_relative 'vertical_hallway'
require 'rmagick'

class Dungeon

  def initialize( dungeon_size )
    @dungeon_size = dungeon_size
    @rooms = {}
    @hallways = []
    1.upto(dungeon_size) do |top|
      1.upto(dungeon_size) do |left|
        room = Room.new( top, left )

        unless left == dungeon_size
          h = HorizontalHallway.new( room )
          @hallways << h
        end

        unless top == dungeon_size
          h = VerticalHallway.new( room )
          @hallways << h
        end

        @rooms[ [ top, left ] ] = room
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
    @hallways.each{ |h| h.draw( gc ) }

    gc.draw( canvas )
    canvas.write( 'out/dungeon.jpg' )

  end

end

Dungeon.new( 3 ).draw