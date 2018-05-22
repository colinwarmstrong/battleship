class Space

  def initialize
    @filled = false
    @hit = false
  end

  def fill
    @filled = true
  end

  def filled?
    @filled
  end

end
