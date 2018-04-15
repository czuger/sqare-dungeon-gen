require_relative 'test_helper'
require 'matrix'

class DungeonGeneration < Minitest::Test

  def setup
    s_seed = nil
    s_seed = 236222324035710783327094102724920156016
    seed = s_seed ? s_seed : Random.new_seed
    # puts "Dungeon seed = #{seed}"
    srand( seed )

    @d = Dungeon.new
    @d.generate( 3, [1, 1, 1, 1] )

    @avail_rooms_ids = @d.rooms.keys
    @unavail_rooms_ids = Matrix.build( 3 ).to_a.map{ |e| [ e[0]+1, e[1]+1 ] } - @d.rooms.keys

    @first_avail_room_id = @avail_rooms_ids.first
    @first_unavail_room_id = @unavail_rooms_ids.first
    @first_avail_direction = @d.available_directions.first
  end

  def test_columns_are_created
    @d = Dungeon.new
    @d.generate( 8, [1, 1, 1, 1] )
    refute_empty @d.rooms.values.select{ |r| !r.decorations.empty? }
  end

  def test_generate_a_full_dungeon
    refute @d.rooms[@first_unavail_room_id]
    assert @d.rooms[@first_avail_room_id]
  end

  def test_save_and_load_from_json
    new_d = Dungeon.from_json( @d.to_json )
    assert_equal @first_avail_room_id, new_d.rooms[@first_avail_room_id].id
    refute new_d.rooms[@first_unavail_room_id]
  end

  def test_save_and_load_from_json_and_navigate
    # pp @d.to_json
    new_d = Dungeon.from_json( @d.to_json )
    # p @d.available_directions
    assert_equal @first_avail_room_id, new_d.rooms[@first_avail_room_id].id
    refute new_d.rooms[@first_unavail_room_id]
    cd = @d.current_room
    @d.set_next_room(@first_avail_direction)
    refute_equal cd, @d.current_room
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
    refute_empty @d.available_directions
  end

  def test_navigation_in_dungeon
    # puts 'Avail directions = ' + @d.available_directions.to_s
    # puts 'Current room = ' + @d.current_room.to_s
    cd = @d.current_room
    @d.set_next_room(@d.available_directions.first)
    refute_equal cd, @d.current_room
    # puts 'Current room = ' + @d.current_room.to_s
    @d.draw_current_room('out/tmp_room.jpg')
    assert File.exist?('out/tmp_room.jpg')
    @d.set_next_room(@d.available_directions.first)
    @d.draw_current_room('out/tmp_room.jpg')
    assert File.exist?('out/tmp_room.jpg')
  end

  def test_hoard_room_contains_hoard_message
    @d.rooms.each do |_, room|
      if room.content == 'H'
        assert_equal 'The treasure, you find it.', room.content_description
      elsif room.content == 'T'
        assert_match /The room contains a pit. Make a perception check against \d+. In case of failure the first character takes \d+ hp./, room.content_description
      end
    end
  end

end