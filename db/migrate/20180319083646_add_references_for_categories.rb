class AddReferencesForCategories < ActiveRecord::Migration[5.1]
  def change
    add_reference :categories, :categorizable, polymorphic: true
  end
end
