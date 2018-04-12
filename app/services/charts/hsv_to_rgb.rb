class Charts::HSVToRGB
  def initialize(h, s, v)
    @h = h
    @s = s
    @v = v
  end

  def convert
    h_i = (@h * 6).to_i
    f = @h * 6 - h_i
    p = @v * (1 - @s)
    q = @v * (1 - f * @s)
    t = @v * (1 - (1 - f) * @s)

    hsv_to_rgb_values_converter(h_i, p, q, t, @v)
  end

  private

  def hsv_to_rgb_values_converter(h_i, p, q, t, v)
    case h_i
    when 0
      set_rgb(v, t, p)
    when 1
      set_rgb(q, v, p)
    when 2
      set_rgb(p, v, t)
    when 3
      set_rgb(p, q, v)
    when 4
      set_rgb(t, p, v)
    when 5
      set_rgb(v, p, q)
    end
  end

  def set_rgb(r, g, b)
    [(r * 256).to_i, (g * 256).to_i, (b * 256).to_i]
  end
end
