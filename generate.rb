require_relative 'lib/dungeon'

s = Random.new
p s.seed

d = Dungeon.new( 3 )

d.draw( 'out/dungeon.jpg' )
# d.draw_current_room( 'out/room.jpg'  )
