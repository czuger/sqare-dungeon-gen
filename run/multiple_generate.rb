require_relative '../lib/dungeon'

1.upto 100 do
  d = Dungeon.new( 5 )
  d.generate_dungeon
  d.to_json
end