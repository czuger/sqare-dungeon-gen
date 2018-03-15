require_relative '../misc/drawable_object'

class Hallway < DrawableObject

  attr_reader :disabled, :rooms, :hallway_id
  attr_accessor :hallway_id

  # Should be half room size
  HALLWAYS_LENGTH=6
  HALLWAYS_WIDTH=2

  def initialize
    @disabled = false
    @hallway_id = nil
  end

  def disable!
    @disabled = true
  end

  def set_draw_base_room( draw_base_room )
    @draw_base_room = draw_base_room
  end

  def to_hash
    { hallway_id: @hallway_id, klass: self.class.name, disabled: @disabled, draw_base_room: @draw_base_room.room_id }
  end

  def get_direction_array( rooms_keys, room, input_output )
    return [ nil, nil ] if disabled
    return [ input_output[0], self ] if rooms_keys[0] == room.top_left_array
    return [ input_output[1], self ] if rooms_keys[1] == room.top_left_array
    [ nil, nil ]
  end

  private

  def draw( gc, width, height, min_x, max_x, min_y, max_y, x_decal: 0, y_decal: 0 )
    gc.rectangle( min_x, min_y, max_x, max_y )

    # Squares
    1.upto( width ).each do |t|
      gc.line( min_x + SQUARE_SIZE_IN_PIXELS*t - x_decal, min_y, min_x + SQUARE_SIZE_IN_PIXELS*t - x_decal, max_y )
    end

    1.upto( height ).each do |t|
      gc.line( min_x, min_y + SQUARE_SIZE_IN_PIXELS*t - y_decal, max_x, min_y + SQUARE_SIZE_IN_PIXELS*t - y_decal )
    end
  end

end