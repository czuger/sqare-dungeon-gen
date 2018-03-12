require_relative 'lib/dungeon'

srand 107477104619628015740973409685440399789
# p s.seed

d = Dungeon.new( 3 )

d.draw( 'out/dungeon.jpg' )
d.draw_current_room( 'out/room.jpg'  )
