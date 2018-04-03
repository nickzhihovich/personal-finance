class Charts::ColorsArray < Struct.new(:count)
  def colors
    collors_array
  end

  private

  def collors_array
    golden_ratio_conjugate = 0.618033988749895
    h = rand

    gen_html do
      h += golden_ratio_conjugate
      h %= 1
      hsv_to_rgb(h, 0.6, 0.85)
    end
  end

  def gen_html
    result = []
    count.times do
      r, g, b = yield
      result << "rgb(#{r}, #{g}, #{b})"
    end
    result
  end

  def hsv_to_rgb(h, s, v)
    h_i = (h * 6).to_i
    f = h * 6 - h_i
    p = v * (1 - s)
    q = v * (1 - f * s)
    t = v * (1 - (1 - f) * s)

    hsv_to_rgb_values_converter(h_i, p, q, t, v)
  end

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
