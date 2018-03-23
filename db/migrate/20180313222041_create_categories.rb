class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :title
      t.integer :amount
      t.integer :user_id
      t.timestamps
    end
  end
end
