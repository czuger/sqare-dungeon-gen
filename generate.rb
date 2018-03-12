require_relative 'lib/dungeon'
require_relative 'lib/walker'
# srand 27937539071995868852976873990277349006
# p Random.new.seed

d = Dungeon.new( 3 )

# d.draw( 'out/dungeon.jpg' )

`rm out/room.jpg`
d.draw_current_room( 'out/room.jpg'  )

Walker.new( d ).main_loop
