require_relative 'test_helper'

class NonGeneratedDungeon < Minitest::Test

  def setup
    s_seed = nil
    s_seed = 236222324035710783327094102724920156016
    seed = s_seed ? s_seed : Random.new_seed
    # puts "Dungeon seed = #{seed}"
    srand( seed )

    @d = Dungeon.new
    # Dungeon is not generated in this test, mostly to test error cases.
  end

  def test_generate_a_full_dungeon
    assert_raises do
      @d.rooms[[1,1]]
    end
    assert_raises do
      @d.rooms[[2,1]]
    end
  end

  def test_save_and_load_from_json
    assert_raises do
      Dungeon.from_json( @d.to_json )
    end
  end

  def test_full_dungeon_drawing
    assert_raises do
      @d.draw('out/tmp_full.jpg')
    end
  end

  def test_room_dungeon_drawing
    assert_raises do
      @d.draw_current_room('out/tmp_room.jpg')
    end
  end

  def test_dungeon_printing
    assert_raises do
      @d.print_dungeon('out/tmp_dungeon.txt')
    end
  end

  def test_directions
    assert_raises do
      @d.available_directions
    end
  end

  def test_navigation_in_dungeon
    assert_raises do
      @d.set_next_room(:left)
    end
  end

end