require_relative '../misc/drawable_object'
require_relative '../hallways/hallway'
require_relative 'room_content'
require_relative 'room_draw'
require 'hazard'

class Room < DrawableObject

  SQUARES_BETWEEN_ROOMS = Hallway::HALLWAYS_LENGTH
  ROOM_SQUARE_SIZE = 12

  attr_reader :top, :left, :entry_room, :min_x, :min_y, :max_x, :max_y, :content, :content_description, :decorations
  attr_accessor :id

  include RoomContent
  include RoomDraw

  def initialize( top, left, lair, room_data = {} )
    @top = room_data['top'] ? room_data['top'].to_i : top
    @left = room_data['left'] ? room_data['left'].to_i : left
    @content = room_data['content']
    @content_description = room_data['content_description']
    @entry_room = room_data['entry_room']
    @id = room_data['id'] ? room_data['id'] : [ top, left ]
    @decorations = room_data['decorations'] ? room_data['decorations'] : []
    create_encounters( lair ) unless room_data['content_description']
    create_decorations unless room_data['decorations']
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
    {id: @id, entry_room: @entry_room, content: @content, content_description: @content_description,
     top: @top, left: @left, decorations: @decorations,
     connected_hallways: hallways.connected_hallways( self ).map{ |k, h| { k => h.to_hash } } }
  end

  def to_json_hash( hallways )
    h = to_hash( hallways )
    h.delete(:connected_hallways)
    h
  end

end