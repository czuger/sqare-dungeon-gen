require_relative 'room'

class Dungeon

  def initialize( dungeon_size )
    @rooms = {}
    1.upto(dungeon_size) do |top|
      1.upto(dungeon_size) do |left|
        @rooms[ [ top, left ] ] = Room.new( top, left )
      end
    end
  end

end

Dungeon.new( 4 )