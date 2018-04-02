class CategoryDecorator < Draper::Decorator
  delegate_all

  def to_label
    "#{title} | #{amount}"
  end
end
