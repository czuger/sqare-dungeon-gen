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
      direction = _directions[direction]
      p direction

      p @dungeon.set_next_room( direction )
      @dungeon.draw_current_room( 'out/room.jpg'  )

    end
  end

end