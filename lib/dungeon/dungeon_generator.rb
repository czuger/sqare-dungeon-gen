require 'matrix'

module DungeonGenerator

  def generate( output=false )
    @output = output
    create_dungeon
    create_entry
    connect_hallways
    delete_rooms
    generate_treasure
    @dungeon_generated = true
  end

  private

  def assert_dungeon_generated
    raise "Dungeon hasn't been generated" unless @dungeon_generated
  end

  def generate_treasure
    rooms_distances = { }
    @rooms.keys.each do |room_id|
      rooms_distances[ room_id ] = distance_between_rooms_ids( @entry.room_id, room_id )
    end
    max_distance = rooms_distances.values.max
    rooms_distances.delete_if {|_, value| value != max_distance }
    treasure_room_id = rooms_distances.keys.sample
    @rooms[treasure_room_id].set_treasure_room
  end

  def create_entry
    @entry = random_entry_room
    @entry.set_entry_room
    @current_room = @entry
  end

  def distance_between_rooms_ids( r_id_1, r_id_2 )
    Math.sqrt( (r_id_1[0] - r_id_2[0])**2  + (r_id_1[1] - r_id_2[1])**2  ).ceil
  end

  def create_dungeon
    Matrix.build( @dungeon_size ){ |r, c| [ r+1, c+1 ] }.to_a.flatten(1).each do |top, left|
      @rooms[ [ top, left ] ] = Room.new( top, left, @lair )
       @rooms[ [ top, left ] ].room_id = [ top, left ]
    end
  end

  def connect_hallways
    Matrix.build( @dungeon_size ){ |r, c| [ r+1, c+1 ] }.to_a.flatten(1).each do |top, left|
      @hallways.connect_rooms( @rooms[ [ top, left ] ],@rooms[ [ top, left+1 ] ], HorizontalHallway.new ) unless left == @dungeon_size
      @hallways.connect_rooms( @rooms[ [ top, left ] ],@rooms[ [ top+1, left ] ], VerticalHallway.new ) unless top == @dungeon_size
    end
  end

  # Coef must be a number between 0 -> 1
  # for example 1/3 mean that we will delete 1/3 of the rooms
  def delete_rooms

    to_delete_rooms_keys = @rooms.keys.shuffle
    puts "Current dungeon size = #{@rooms.count}" if @output
    target_dungeon_size = @rooms.count - ((@dungeon_size**2)*@rooms_removal_coef).ceil
    puts "Target dungeon size = #{target_dungeon_size}" if @output

    while @rooms.count > target_dungeon_size && !to_delete_rooms_keys.empty?

      to_delete_room_key = to_delete_rooms_keys.shift
      tmp_rooms = @rooms.clone
      tmp_rooms.delete( to_delete_room_key )

      dw = DungeonWalker.new( tmp_rooms, @dungeon_size, @entry )
      # If we can walk to all the rooms in the dungeon, then the room deletion is validated
      if dw.walk_rooms.count == tmp_rooms.count
        @hallways.disable_hallways!( to_delete_room_key )
        @rooms.delete( to_delete_room_key )
      end
      # Otherwise we try with the next room

    end

    puts "Final dungeon size = #{@rooms.count}" if @output
  end

  def external_rooms
    @rooms.values.select{ |r| r.top == 1 || r.left == 1 || r.top == @dungeon_size || r.left == @dungeon_size }
  end

  def random_entry_room
    external_rooms.sample
  end

end