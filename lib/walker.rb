class Walker

  def initialize( dungeon )
    @dungeon = dungeon
  end

  def directions
    Hash[ @dungeon.hallways.directions( @dungeon.current_room ).map{ |e| [ e.to_s[0], e ] } ]
  end

  def main_loop
    loop do
      _directions = directions

      p _directions

      direction = gets.chomp
      p direction
      direction = _directions[direction]
      p direction
      p @dungeon.current_room.connected_hallways[direction].connected_room(direction)

    end
  end

end