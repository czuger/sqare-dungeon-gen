class HallwaysList

  def initialize
    @hallways = {}
  end

  def connect_rooms( r1, r2, hallway )
    @hallways[ [ r1.top_left_array, r2.top_left_array ] ] = hallway
    hallway.hallway_id = [ r1.top_left_array, r2.top_left_array ]
    hallway.set_draw_base_room( r1 )
  end

  def get_room_id_from_direction( room, direction )
    connections = connected_hallways( room )
    connected_hallway = connections[direction]
    unless connected_hallway
      raise "Can't find a connected hallway. direction = #{direction.inspect}, connections = #{connections.inspect}"
    end
    connected_hallway.get_connected_room(direction)
  end

  def connected_hallways( room )
    hallways = {}
    @hallways.each_pair do |rooms_keys, hallway|
      d, h = hallway.get_direction_array( rooms_keys, room )
      hallways[d] = h if d
    end
    hallways
  end

  def directions( room )
    connected_hallways(room).keys.sort
  end

  def draw_from_base_room( gc )
    @hallways.each_pair{ |_, h| h.draw_from_base_room( gc ) unless h.disabled }
  end

  def draw_hallways_connected_to_given_room_at_origin( gc, room )
    connections = connected_hallways( room )
    connections.each do |direction, hallway|
      hallway.draw_from_given_room( gc, room, direction )
    end
  end

  def disable_hallways!( room_key )
    @hallways.each_pair do |rooms_keys, hallway|
      if rooms_keys[0] == room_key || rooms_keys[1] == room_key
        hallway.disable!
      end
    end
  end

  def to_hash
    @hallways.values.map{ |v| v.to_hash }
  end

  def from_json( data, rooms )
    data.each do |hallway_data|
      # pp hallway_data
      r1 = rooms[hallway_data['hallway_id'][0]]
      r2 = rooms[hallway_data['hallway_id'][1]]
      if r1 && r2
        hallway = Object.const_get(hallway_data['klass']).new
        hallway.disable! if hallway_data['disabled']
        hallway.set_draw_base_room(r1)
        connect_rooms( r1, r2, hallway )
      end
    end
  end

end