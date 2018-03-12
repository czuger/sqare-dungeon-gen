class HallwaysList

  def initialize
    @hallways = {}
  end

  def connect_rooms( r1, r2, hallway )
    @hallways[ [ r1.top_left_array, r2.top_left_array ] ] = hallway
    hallway.set_draw_base_room( r1 )
  end

  def draw_from_base_room( gc )
    @hallways.each_pair{ |_, h| h.draw_from_base_room( gc ) unless h.disabled }
  end

  def disable_hallways!( room_key )
    @hallways.each_pair do |rooms_keys, hallway|
      if rooms_keys[0] == room_key || rooms_keys[1] == room_key
        hallway.disable!
      end
    end
  end
end