require 'hazard'
require_relative 'room_traps'

module RoomContent

  @@monsters_generator = nil
  @@party_levels = nil
  @@encounters_difficulty = nil

  attr_accessor :party_levels, :encounters_difficulty

  include RoomTraps

  def set_entry_room
    @entry_room = true
    @content = 'E'
    @content_description = 'This room is the entry room.'
  end

  def set_treasure_room
    @content = 'H'
    @content_description = 'The treasure, you find it.'
  end

  private

  def create_encounters
    @content_description = 'Nothing in this room.'
    roll = Hazard.d6
    generate_trap if roll == 1
    generate_monster if roll > 1 && roll < 6
  end

  def create_decorations
    roll = Hazard.d6
    create_four_columns if roll == 1
  end

  def create_four_columns
    near = (Room::ROOM_SQUARE_SIZE/8.0).ceil
    distant = Room::ROOM_SQUARE_SIZE-[ (Room::ROOM_SQUARE_SIZE/8.0).ceil*2, 3 ].max

    column_1 = { top: near, left: near }
    column_2 = { top: near, left: distant }
    column_3 = { top: distant, left: near }
    column_4 = { top: distant, left: distant }

    @decorations << { decoration_type: :four_columns, decoration_data: [ column_1, column_2, column_3, column_4 ] }
  end

  def generate_monster
    @content = 'M'
    @content_description = @@monsters_generator.get_party_encounter( @@encounters_difficulty, *@@party_levels ).to_s + '.'
  end

end