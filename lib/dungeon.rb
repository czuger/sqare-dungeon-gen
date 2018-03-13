require_relative 'room'
require_relative 'dungeon_walker'
require_relative 'dungeon_generator'
require_relative 'dungeon_draw'
require_relative 'hallways/horizontal_hallway'
require_relative 'hallways/vertical_hallway'
require_relative 'hallways/hallways_list'
require 'rmagick'
require 'pp'
require 'json'

class Dungeon

  attr_reader :current_room, :hallways

  include DungeonGenerator
  include DungeonDraw

  def initialize( dungeon_size, rooms_removal_coef = 0.3 )
    @dungeon_size = dungeon_size
    @rooms = {}
    @hallways = HallwaysList.new
    @rooms_removal_coef = rooms_removal_coef

    create_dungeon
    create_entry
    connect_hallways
    delete_rooms
    generate_treasure
  end

  def set_next_room( direction )
    room_id = @hallways.get_room_id_from_direction( @current_room, direction )
    @current_room = @rooms[ room_id ]
  end

  def available_directions
    @hallways.directions( @current_room )
  end

  def to_json
    {
        dungeon_size: @dungeon_size,
        rooms_removal_coef: @rooms_removal_coef,
        entry_room_id: @entry.room_id,
        current_room: @current_room.room_id,
        rooms: @rooms.values.map{ |r| r.to_json( @hallways ) },
        hallways: @hallways.to_json
    }
  end

end