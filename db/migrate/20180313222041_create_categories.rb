class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :title
      t.string :amount
      t.integer :user_id
      t.timestamps
    end
  end
end
