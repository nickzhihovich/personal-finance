class Charts::ColorsArray < Struct.new(:count)
  def collors_array
    h = rand

    gen_html do
      h += golden_ratio_conjugate
      h %= 1
      hsv_to_rgb(h, 0.6, 0.85)
    end
  end

  private

  def gen_html
    count.times.reduce([]) do |result|
      r, g, b = yield
      result << "rgb(#{r}, #{g}, #{b})"
    end
  end

  def hsv_to_rgb(h, s, v)
    Charts::HSVToRGB.new(h, s, v).convert
  end

  def golden_ratio_conjugate
    0.618033988749895
  end
end
