require_relative 'test_helper'

class DungeonGeneration < Minitest::Test

  def setup
    s_seed = nil
    s_seed = 236222324035710783327094102724920156016
    seed = s_seed ? s_seed : Random.new_seed
    # puts "Dungeon seed = #{seed}"
    srand( seed )

    @d = Dungeon.new( 3 )
    @d.generate
  end

  def test_generate_a_full_dungeon
    refute @d.rooms[[2,1]]
    assert @d.rooms[[1,1]]
  end

  def test_save_and_load_from_json
    new_d = Dungeon.from_json( @d.to_json )
    assert_equal @d.rooms[[1,1]].room_id, new_d.rooms[[1,1]].room_id
    refute new_d.rooms[[2,1]]
  end

  def test_save_and_load_from_json_and_navigate
    new_d = Dungeon.from_json( @d.to_json )
    assert_equal @d.rooms[[1,1]].room_id, new_d.rooms[[1,1]].room_id
    refute new_d.rooms[[2,1]]
    @d.set_next_room(:right)
  end

  def test_full_dungeon_drawing
    @d.draw('out/tmp_full.jpg')
    assert File.exist?('out/tmp_full.jpg')
    `rm out/tmp_full.jpg`
  end

  def test_room_dungeon_drawing
    @d.draw_current_room('out/tmp_room.jpg')
    assert File.exist?('out/tmp_room.jpg')
    `rm out/tmp_room.jpg`
  end

  def test_dungeon_printing
    @d.print_dungeon('out/tmp_dungeon.txt')
    assert File.exist?('out/tmp_dungeon.txt')
    `rm out/tmp_dungeon.txt`
  end

  def test_directions
    assert_equal [:right, :top], @d.available_directions
    p @d.current_room.content_description
  end

  def test_navigation_in_dungeon
    @d.set_next_room(:right)
    @d.draw_current_room('out/tmp_room.jpg')
    assert File.exist?('out/tmp_room.jpg')
    assert_equal [:left], @d.available_directions
    @d.set_next_room(:left)
    @d.draw_current_room('out/tmp_room.jpg')
    assert File.exist?('out/tmp_room.jpg')
    assert_equal [:right, :top], @d.available_directions
  end


end