require 'colorize'

class Space
  attr_accessor :filled, :hit

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

  def hit?
    @hit
  end

  def take_hit
    @hit = true
  end

  def p1_display
    if @filled == true  && @hit == true
      'H'.red
    elsif @filled == false  && @hit == true
      'M'
    elsif @filled == true && @hit == false
      'S'.light_black
    else
      '~'.light_blue
    end
  end

  def cpu_display
    if @filled == true  && @hit == true
      'H'.red
    elsif @filled == false  && @hit == true
      'M'
    else
      '~'.light_blue
    end
  end

end
