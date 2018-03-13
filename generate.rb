require_relative 'lib/dungeon'
require_relative 'lib/walker'
# srand 27937539071995868852976873990277349000
# p Random.new.seed

d = Dungeon.new( 4 )

d.print_dungeon
d.draw( 'out/dungeon.jpg' )

d.draw_current_room( 'out/room.jpg'  )

# Walker.new( d ).main_loop

p d.available_directions