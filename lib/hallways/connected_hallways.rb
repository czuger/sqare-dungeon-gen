class ConnectedHallways

  def disable_all!
    @left_hallway&.disable!
    @right_hallway&.disable!
    @top_hallway&.disable!
    @bottom_hallway&.disable!
  end

  def connect_left( hallway )
    @left_hallway = hallway  
  end

  def connect_right( hallway )
    @right_hallway = hallway
  end

  def connect_top( hallway )
    @top_hallway = hallway
  end

  def connect_bottom( hallway )
    @bottom_hallway = hallway
  end

  def draw_left( hallway )
    @left_hallway = hallway
  end

  def draw_right( hallway )
    @right_hallway = hallway
  end

  def draw_top( hallway )
    @top_hallway = hallway
  end

  def draw_bottom( hallway )
    @bottom_hallway = hallway
  end

end