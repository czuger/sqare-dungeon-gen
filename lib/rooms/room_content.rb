require 'hazard'
require_relative 'room_traps'

module RoomContent

  attr_accessor :party_levels, :encounters_difficulty

  include RoomTraps

  CONTENT_DESC_EMPTY='Nothing in this room.'
  CONTENT_DESC_MONSTERS_CLEARED='Slain monsters lying on the floor.'
  CONTENT_DESC_TRAP_CLEARED='A deactivated trap. Be carefull.'

  def set_entry_room
    @entry_room = true
    @content = 'E'
    @content_description = 'This room is the entry room.'
  end

  def set_treasure_room
    @content = 'H'
    @content_description = 'The treasure, you find it.'
  end

  def clear
    case @content
      when 'T'
        @content = nil
        @content_description = CONTENT_DESC_TRAP_CLEARED
      when 'M'
        @content = nil
        @content_description = CONTENT_DESC_MONSTERS_CLEARED
    end
  end

  private

  def create_encounters( lair )
    @content_description = CONTENT_DESC_EMPTY
    roll = Hazard.d6
    generate_trap if roll == 1
    generate_monster( lair ) if roll > 1 && roll < 6
  end

  def create_decorations
    roll = Hazard.d6
    create_four_columns if roll >= 5
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

  def generate_monster( lair )
    @content = 'M'
    @content_description = lair.encounter.to_s + '.'
  end

end