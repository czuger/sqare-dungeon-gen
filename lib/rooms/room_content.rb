require 'hazard'

module RoomContent

  attr_reader :content_description

  @@monsters_generator = nil

  private

  def create_encounters
    roll = Hazard.d6
    @content = 'T' if roll == 1
    @content = 'M' if roll > 1 && roll < 6
    set_content_desc
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

  def set_content_desc
    @content_description = case @content
      when 'M'
        @@monsters_generator.get_encounter( :medium, 3, 3, 3, 3 ).to_s + '.'
      else
        'Nothing in this room.'
    end
  end

end