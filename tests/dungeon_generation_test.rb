require_relative 'test_helper'

class DungeonGeneration < Minitest::Test

  def setup
    s_seed = nil
    s_seed = 236222324035710783327094102724920156016
    seed = s_seed ? s_seed : Random.new_seed
    puts "Dungeon seed = #{seed}"
    srand( seed )

    @d = Dungeon.new( 3 )
  end

  def test_generate_a_full_dungeon
    @d.generate_dungeon
    # p @d.rooms
    refute @d.rooms[[1,1]]
    assert @d.rooms[[2,1]]
  end
end