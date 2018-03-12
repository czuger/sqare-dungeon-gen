require_relative 'room'
require_relative 'horizontal_hallway'
require_relative 'vertical_hallway'
require_relative 'dungeon_walker'
require 'rmagick'

class Dungeon

  def initialize( dungeon_size )
    @dungeon_size = dungeon_size
    @rooms = {}
    @hallways = []

    create_dungeon
    connect_hallways
    delete_rooms( 1.0/3 )

    p @rooms.keys

    # p DungeonWalker.walk_rooms( @rooms ).count

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

  # Coef must be a number between 0 -> 1
  # for example 1/3 mean that we will delete 1/3 of the rooms
  def delete_rooms( coef )

    to_delete_rooms_keys = @rooms.keys.shuffle
    target_dungeon_size = @rooms.count - ((@dungeon_size**2)*coef).ceil

    while @rooms.count > target_dungeon_size && !to_delete_rooms_keys.empty?

      to_delete_room_key = to_delete_rooms_keys.shift
      tmp_rooms = @rooms.clone
      tmp_rooms.delete( to_delete_room_key )

      dw = DungeonWalker.new( tmp_rooms, @dungeon_size )
      # If we can walk to all the rooms in the dungeon, then the room deletion is validated
      if dw.walk_rooms( tmp_rooms ).count == tmp_rooms.count
        @rooms[ to_delete_room_key ].disable_hallways
        @rooms.delete( to_delete_room_key )
      end
      # Otherwise we try with the next room

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

Dungeon.new( 7 ).draw