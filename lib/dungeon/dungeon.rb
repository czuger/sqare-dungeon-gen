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

  def initialize
    @dungeon_size = @rooms_removal_coef = @rooms = @hallways = @dungeon_generated = @current_room = @lair = nil
  end

  def set_next_room( direction )
    assert_dungeon_generated
    # puts 'Current room = ' + @current_room.id.to_s
    room_id = @hallways.get_room_id_from_direction( @current_room, direction )
    # puts 'Connected room id = ' + room_id.to_s
    # puts 'Rooms = ' + @rooms.keys.to_s
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
        entry_room_id: @entry.id,
        current_room_id: @current_room.id,
        dungeon_generated: @dungeon_generated,
        rooms: @rooms.values.map{ |r| r.to_json_hash( @hallways ) },
        hallways: @hallways.to_hash,
        lair: @lair.to_hash
    }.to_json
  end

  def self.from_json( json_string )
    data = JSON.parse( json_string )
    dungeon = Dungeon.new
    dungeon.generate( data['dungeon_size'], data['rooms_removal_coef'],
                           lair:Lairs.from_hash( data['lair'] ) )
    dungeon.from_json(data)
    dungeon
  end

  def from_json( data )
    raise 'You must parse the json string before calling this method' if data.is_a? String

    @dungeon_size = data['dungeon_size']
    @rooms_removal_coef = data['rooms_removal_coef']
    @dungeon_generated = data['dungeon_generated']
    @rooms = Hash[ data['rooms'].map{ |dr| [ dr['id'], Room.new( dr['top'], dr['left'], @lair, dr ) ] } ]
    @hallways.from_json(data['hallways'], @rooms)

    @entry = @rooms[data['entry_room_id']]
    @current_room = @rooms[data['current_room_id']]
  end

  private

  def check_params( dungeon_size, party_levels, encounters_difficulty, rooms_removal_coef )
    raise "dungeon_size should not be null" if dungeon_size == 0
  end

end