class CreateCategoriesTable < ActiveRecord::Migration
  def up
    create_table :categories do |cat|
      cat.string :name

      cat.timestamps
    end
  end

  def down
    drop_table :categories
  end
end
