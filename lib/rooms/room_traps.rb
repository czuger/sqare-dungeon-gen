# This is very basic, need to improve

module RoomTraps

  private

  def generate_trap
    dd = 10+Hazard.d4
    degats = Hazard.m2d10
    @content = 'T'
    @content_description = "The room contains a pit. Make a perception check against #{dd}. In case of failure the first character takes #{degats} hp."
  end

end

