class HallwaysList

  def initialize
    @hallways = {}
  end

  def connect_rooms( r1, r2, hallway )
    @hallways[ [ r1.top_left_array, r2.top_left_array ] ] = hallway
    hallway.set_draw_base_room( r1 )
    hallway.set_input_room( r1 )
    hallway.set_output_room( r1 )
  end

  def directions( room )
    directions = []
    @hallways.each_pair do |rooms_keys, hallway|

      next if hallway.disabled

      if rooms_keys[0] == room.top_left_array
        if hallway.is_a?( HorizontalHallway )
          directions << :right
        else
          directions << :bottom
        end
      end

      if rooms_keys[1] == room.top_left_array
        if hallway.is_a?( HorizontalHallway )
          directions << :left
        else
          directions << :top
        end
      end
    end
    directions
  end

  def draw_from_base_room( gc )
    @hallways.each_pair{ |_, h| h.draw_from_base_room( gc ) unless h.disabled }
  end

  def draw_hallways_connected_to_given_room_at_origin( gc, room )
    @hallways.each_pair do |rooms_keys, hallway|

      next if hallway.disabled

      if rooms_keys[0] == room.top_left_array
        if hallway.is_a?( HorizontalHallway )
          hallway.draw_right_from_given_room( gc, room )
        else
          hallway.draw_bottom_from_given_room( gc, room )
        end
      end

      if rooms_keys[1] == room.top_left_array
        if hallway.is_a?( HorizontalHallway )
          hallway.draw_left_from_given_room( gc, room )
        else
          hallway.draw_top_from_given_room( gc, room )
        end
      end
    end

  end

  def disable_hallways!( room_key )
    @hallways.each_pair do |rooms_keys, hallway|
      if rooms_keys[0] == room_key || rooms_keys[1] == room_key
        hallway.disable!
      end
    end
  end

end