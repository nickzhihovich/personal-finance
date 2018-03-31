class Categories::Creator < Struct.new(:attributes)
  def create
    create_category
  end

  private

  def create_category
    attributes[:parent].categories.create(attributes[:params].merge(amount: 0))
  end
end
