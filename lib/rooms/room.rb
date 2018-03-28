require_relative '../misc/drawable_object'
require_relative '../hallways/hallway'
require_relative 'room_content'
require_relative 'room_draw'
require 'hazard'

class Room < DrawableObject

  SQUARES_BETWEEN_ROOMS = Hallway::HALLWAYS_LENGTH
  ROOM_SQUARE_SIZE = 12

  attr_reader :top, :left, :entry_room, :min_x, :min_y, :max_x, :max_y, :content, :content_description
  attr_accessor :room_id

  include RoomContent
  include RoomDraw

  def initialize( top, left )
    @top = top
    @left = left
    @decorations = {}
    @content = nil
    @content_description = nil
    @entry_room = nil
    @room_id = [ top, left ]
    @decorations = []
    create_encounters
    create_decorations
  end

  def self.set_monsters_generator( monsters_generator )
    @@monsters_generator = monsters_generator
  end

  def top_left_array
    [ @top, @left ]
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

  def to_hash( hallways )
    { room_id: @room_id, entry_room: @entry_room, content: @content, content_description: @content_description,
      top: @top, left: @left,
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
    @content_description = room_data['content_description']
    @top = room_data['top'].to_i
    @left = room_data['left'].to_i
    self
  end

  def self.set_encounters_data( encounters_difficulty, party_levels )
    @@party_levels = party_levels
    @@encounters_difficulty = encounters_difficulty.to_sym
  end

  def self.get_encounters_data
    { party_levels: @@party_levels, encounters_difficulty: @@encounters_difficulty }
  end

end