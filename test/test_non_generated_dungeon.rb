require_relative 'test_helper'

class NonGeneratedDungeon < Minitest::Test

  def setup
    s_seed = nil
    s_seed = 236222324035710783327094102724920156016
    seed = s_seed ? s_seed : Random.new_seed
    puts "Dungeon seed = #{seed}"
    srand( seed )

    @d = Dungeon.new( 3 )
  end

  def test_generate_a_full_dungeon
    refute @d.rooms[[1,1]]
    refute @d.rooms[[2,1]]
  end

  def test_save_and_load_from_json
    assert_raises do
      Dungeon.from_json( @d.to_json )
    end
  end

  def test_full_dungeon_drawing
    @d.draw('out/tmp_full.jpg')
    assert File.exist?('out/tmp_full.jpg')
    `rm out/tmp_full.jpg`
  end

  def test_room_dungeon_drawing
    assert_raises do
      @d.draw_current_room('out/tmp_room.jpg')
    end
  end

  def test_dungeon_printing
    @d.print_dungeon('out/tmp_dungeon.txt')
    assert File.exist?('out/tmp_dungeon.txt')
    `rm out/tmp_dungeon.txt`
  end

  def test_directions
    assert_equal [], @d.available_directions
  end

  def test_navigation_in_dungeon
    assert_raises do
      @d.set_next_room(:left)
    end
  end

  def test_problematic_json_load
    json = '{"dungeon_size":5,"rooms_removal_coef":0.3,"entry_room_id":[1,1],"current_room_id":[1,1],"dungeon_generated":true,"rooms":[{"room_id":[1,1],"entry_room":true,"content":"E","top":1,"left":1},{"room_id":[1,2],"entry_room":null,"content":"M","top":1,"left":2},{"room_id":[1,3],"entry_room":null,"content":"M","top":1,"left":3},{"room_id":[1,4],"entry_room":null,"content":"M","top":1,"left":4},{"room_id":[2,2],"entry_room":null,"content":null,"top":2,"left":2},{"room_id":[2,4],"entry_room":null,"content":"M","top":2,"left":4},{"room_id":[2,5],"entry_room":null,"content":null,"top":2,"left":5},{"room_id":[3,1],"entry_room":null,"content":"T","top":3,"left":1},{"room_id":[3,2],"entry_room":null,"content":null,"top":3,"left":2},{"room_id":[3,4],"entry_room":null,"content":null,"top":3,"left":4},{"room_id":[4,1],"entry_room":null,"content":"M","top":4,"left":1},{"room_id":[4,4],"entry_room":null,"content":null,"top":4,"left":4},{"room_id":[5,1],"entry_room":null,"content":"M","top":5,"left":1},{"room_id":[5,2],"entry_room":null,"content":"M","top":5,"left":2},{"room_id":[5,3],"entry_room":null,"content":"T","top":5,"left":3},{"room_id":[5,4],"entry_room":null,"content":"T","top":5,"left":4},{"room_id":[5,5],"entry_room":null,"content":"H","top":5,"left":5}],"hallways":[{"hallway_id":[[1,1],[1,2]],"klass":"HorizontalHallway","disabled":null,"draw_base_room":[1,1]},{"hallway_id":[[1,1],[2,1]],"klass":"VerticalHallway","disabled":true,"draw_base_room":[1,1]},{"hallway_id":[[1,2],[1,3]],"klass":"HorizontalHallway","disabled":null,"draw_base_room":[1,2]},{"hallway_id":[[1,2],[2,2]],"klass":"VerticalHallway","disabled":null,"draw_base_room":[1,2]},{"hallway_id":[[1,3],[1,4]],"klass":"HorizontalHallway","disabled":null,"draw_base_room":[1,3]},{"hallway_id":[[1,3],[2,3]],"klass":"VerticalHallway","disabled":true,"draw_base_room":[1,3]},{"hallway_id":[[1,4],[1,5]],"klass":"HorizontalHallway","disabled":true,"draw_base_room":[1,4]},{"hallway_id":[[1,4],[2,4]],"klass":"VerticalHallway","disabled":null,"draw_base_room":[1,4]},{"hallway_id":[[1,5],[2,5]],"klass":"VerticalHallway","disabled":true,"draw_base_room":[1,5]},{"hallway_id":[[2,1],[2,2]],"klass":"HorizontalHallway","disabled":true,"draw_base_room":[2,1]},{"hallway_id":[[2,1],[3,1]],"klass":"VerticalHallway","disabled":true,"draw_base_room":[2,1]},{"hallway_id":[[2,2],[2,3]],"klass":"HorizontalHallway","disabled":true,"draw_base_room":[2,2]},{"hallway_id":[[2,2],[3,2]],"klass":"VerticalHallway","disabled":null,"draw_base_room":[2,2]},{"hallway_id":[[2,3],[2,4]],"klass":"HorizontalHallway","disabled":true,"draw_base_room":[2,3]},{"hallway_id":[[2,3],[3,3]],"klass":"VerticalHallway","disabled":true,"draw_base_room":[2,3]},{"hallway_id":[[2,4],[2,5]],"klass":"HorizontalHallway","disabled":null,"draw_base_room":[2,4]},{"hallway_id":[[2,4],[3,4]],"klass":"VerticalHallway","disabled":null,"draw_base_room":[2,4]},{"hallway_id":[[2,5],[3,5]],"klass":"VerticalHallway","disabled":true,"draw_base_room":[2,5]},{"hallway_id":[[3,1],[3,2]],"klass":"HorizontalHallway","disabled":null,"draw_base_room":[3,1]},{"hallway_id":[[3,1],[4,1]],"klass":"VerticalHallway","disabled":null,"draw_base_room":[3,1]},{"hallway_id":[[3,2],[3,3]],"klass":"HorizontalHallway","disabled":true,"draw_base_room":[3,2]},{"hallway_id":[[3,2],[4,2]],"klass":"VerticalHallway","disabled":true,"draw_base_room":[3,2]},{"hallway_id":[[3,3],[3,4]],"klass":"HorizontalHallway","disabled":true,"draw_base_room":[3,3]},{"hallway_id":[[3,3],[4,3]],"klass":"VerticalHallway","disabled":true,"draw_base_room":[3,3]},{"hallway_id":[[3,4],[3,5]],"klass":"HorizontalHallway","disabled":true,"draw_base_room":[3,4]},{"hallway_id":[[3,4],[4,4]],"klass":"VerticalHallway","disabled":null,"draw_base_room":[3,4]},{"hallway_id":[[3,5],[4,5]],"klass":"VerticalHallway","disabled":true,"draw_base_room":[3,5]},{"hallway_id":[[4,1],[4,2]],"klass":"HorizontalHallway","disabled":true,"draw_base_room":[4,1]},{"hallway_id":[[4,1],[5,1]],"klass":"VerticalHallway","disabled":null,"draw_base_room":[4,1]},{"hallway_id":[[4,2],[4,3]],"klass":"HorizontalHallway","disabled":true,"draw_base_room":[4,2]},{"hallway_id":[[4,2],[5,2]],"klass":"VerticalHallway","disabled":true,"draw_base_room":[4,2]},{"hallway_id":[[4,3],[4,4]],"klass":"HorizontalHallway","disabled":true,"draw_base_room":[4,3]},{"hallway_id":[[4,3],[5,3]],"klass":"VerticalHallway","disabled":true,"draw_base_room":[4,3]},{"hallway_id":[[4,4],[4,5]],"klass":"HorizontalHallway","disabled":true,"draw_base_room":[4,4]},{"hallway_id":[[4,4],[5,4]],"klass":"VerticalHallway","disabled":null,"draw_base_room":[4,4]},{"hallway_id":[[4,5],[5,5]],"klass":"VerticalHallway","disabled":true,"draw_base_room":[4,5]},{"hallway_id":[[5,1],[5,2]],"klass":"HorizontalHallway","disabled":null,"draw_base_room":[5,1]},{"hallway_id":[[5,2],[5,3]],"klass":"HorizontalHallway","disabled":null,"draw_base_room":[5,2]},{"hallway_id":[[5,3],[5,4]],"klass":"HorizontalHallway","disabled":null,"draw_base_room":[5,3]},{"hallway_id":[[5,4],[5,5]],"klass":"HorizontalHallway","disabled":null,"draw_base_room":[5,4]}]}'
    Dungeon.from_json( json )
  end


end