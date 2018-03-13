require_relative 'room'
require_relative 'dungeon_walker'
require_relative 'hallways/horizontal_hallway'
require_relative 'hallways/vertical_hallway'
require_relative 'hallways/hallways_list'
require 'rmagick'
require 'pp'

class Dungeon

  attr_reader :current_room, :hallways

  def initialize( dungeon_size, rooms_removal_coef = 0.3 )
    @dungeon_size = dungeon_size
    @rooms = {}
    @hallways = HallwaysList.new
    @rooms_removal_coef = rooms_removal_coef

    create_dungeon
    create_entry
    connect_hallways
    delete_rooms
  end

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
    width = height = ( Room::ROOM_SQUARE_SIZE + Room::SQUARES_BETWEEN_ROOMS * 2 ) * Room::SQUARE_SIZE_IN_PIXELS

    create_gc( width, height )
    @current_room.compute_coords_at_origin
    @current_room.draw( @gc )

    @hallways.draw_hallways_connected_to_given_room_at_origin( @gc, @current_room )

    draw_gc( output_file )
  end

  def print_dungeon
    rooms = {}
    @rooms.each do |_, v|
      rooms[ v.room_id ] = v.to_hash( hallways )
    end
    File.open('out/dungeon.txt','w') do |f|
      PP.pp(rooms,f)
    end
  end

  private

  def create_entry
    @entry = random_entry_room
    @entry.set_entry_room
    @current_room = @entry
  end

  def create_dungeon
    1.upto(@dungeon_size) do |top|
      1.upto(@dungeon_size) do |left|
        @rooms[ [ top, left ] ] = Room.new( top, left )
        @rooms[ [ top, left ] ].room_id = [ top, left ]
      end
    end
  end

  def connect_hallways
    1.upto(@dungeon_size) do |top|
      1.upto(@dungeon_size) do |left|
        @hallways.connect_rooms( @rooms[ [ top, left ] ],@rooms[ [ top, left+1 ] ], HorizontalHallway.new ) unless left == @dungeon_size
        @hallways.connect_rooms( @rooms[ [ top, left ] ],@rooms[ [ top+1, left ] ], VerticalHallway.new ) unless top == @dungeon_size
      end
    end
  end

  # Coef must be a number between 0 -> 1
  # for example 1/3 mean that we will delete 1/3 of the rooms
  def delete_rooms

    to_delete_rooms_keys = @rooms.keys.shuffle
    puts "Current dungeon size = #{@rooms.count}"
    target_dungeon_size = @rooms.count - ((@dungeon_size**2)*@rooms_removal_coef).ceil
    puts "Target dungeon size = #{target_dungeon_size}"

    while @rooms.count > target_dungeon_size && !to_delete_rooms_keys.empty?

      to_delete_room_key = to_delete_rooms_keys.shift
      tmp_rooms = @rooms.clone
      tmp_rooms.delete( to_delete_room_key )

      dw = DungeonWalker.new( tmp_rooms, @dungeon_size, @entry )
      # If we can walk to all the rooms in the dungeon, then the room deletion is validated
      if dw.walk_rooms.count == tmp_rooms.count
        @hallways.disable_hallways!( to_delete_room_key )
        @rooms.delete( to_delete_room_key )
      end
      # Otherwise we try with the next room

    end

    puts "Final dungeon size = #{@rooms.count}"
  end

  def external_rooms
    @rooms.values.select{ |r| r.top == 1 || r.left == 1 || r.top == @dungeon_size || r.left == @dungeon_size }
  end

  def random_entry_room
    external_rooms.sample
  end

  def create_gc( width, height )
    @canvas = Magick::Image.new( width, height )

    @gc = Magick::Draw.new
    @gc.stroke( 'darkslateblue' )
    @gc.fill( 'white' )
  end

  def draw_gc( output_file )
    @gc.draw( @canvas )
    @canvas.write( output_file )
  end

end