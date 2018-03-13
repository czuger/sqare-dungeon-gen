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

      directions << hallway.in_room_connection if rooms_keys[0] == room.top_left_array
      directions << hallway.out_room_connection if rooms_keys[1] == room.top_left_array

    end
    directions
  end

  def draw_from_base_room( gc )
    @hallways.each_pair{ |_, h| h.draw_from_base_room( gc ) unless h.disabled }
  end

  def draw_hallways_connected_to_given_room_at_origin( gc, room )
    @hallways.each_pair do |rooms_keys, hallway|

      next if hallway.disabled

      hallway.draw_in_from_given_room( gc, room ) if rooms_keys[1] == room.top_left_array
      hallway.draw_out_from_given_room( gc, room ) if rooms_keys[0] == room.top_left_array
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