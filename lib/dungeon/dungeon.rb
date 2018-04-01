require_relative '../rooms/room'
require_relative 'dungeon_walker'
require_relative 'dungeon_generator'
require_relative 'dungeon_draw'
require_relative '../hallways/horizontal_hallway'
require_relative '../hallways/vertical_hallway'
require_relative '../hallways/hallways_list'
require 'dd-next-encounters'
require 'rmagick'
require 'pp'
require 'json'

class Dungeon

  attr_reader :current_room, :hallways, :rooms

  include DungeonGenerator
  include DungeonDraw

  def initialize( dungeon_size, party_levels, encounters_difficulty = :medium, rooms_removal_coef = 0.3 )
    @dungeon_size = dungeon_size
    @rooms_removal_coef = rooms_removal_coef
    @rooms = {}
    @hallways = HallwaysList.new
    @dungeon_generated = false
    @current_room = nil

    Room.set_encounters_data( encounters_difficulty, party_levels )

    encounters = Encounters.new
    Room.set_monsters_generator( encounters )
  end

  def set_next_room( direction )
    assert_dungeon_generated
    room_id = @hallways.get_room_id_from_direction( @current_room, direction )
    @current_room = @rooms[ room_id ]
  end

  def available_directions
    assert_dungeon_generated
    @hallways.directions( @current_room )
  end

  def to_json
    assert_dungeon_generated
    {
        dungeon_size: @dungeon_size,
        rooms_removal_coef: @rooms_removal_coef,
        entry_room_id: @entry.room_id,
        current_room_id: @current_room.room_id,
        dungeon_generated: @dungeon_generated,
        rooms: @rooms.values.map{ |r| r.to_json_hash( @hallways ) },
        hallways: @hallways.to_hash,
        encounters_data: Room.get_encounters_data
    }.to_json
  end

  def self.from_json( json_string )
    data = JSON.parse( json_string )
    dungeon = Dungeon.new( data['dungeon_size'], data['rooms_removal_coef'] )
    dungeon.from_json(data)
    dungeon
  end

  def from_json( data )
    raise 'You must parse the json string before calling this method' if data.is_a? String
    Room.set_encounters_data( data['encounters_data']['encounters_difficulty'], data['encounters_data']['party_levels'] )

    @dungeon_size = data['dungeon_size']
    @rooms_removal_coef = data['rooms_removal_coef']
    @dungeon_generated = data['dungeon_generated']
    @rooms = Hash[ data['rooms'].map{ |dr| [ dr['room_id'], Room.new( dr['top'], dr['left'] ).from_json( dr ) ] } ]
    @hallways.from_json(data['hallways'], @rooms)

    @entry = @rooms[data['entry_room_id']]
    @current_room = @rooms[data['current_room_id']]
  end

end