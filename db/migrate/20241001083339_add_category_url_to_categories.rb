class AddCategoryUrlToCategories < ActiveRecord::Migration[7.2]
  def change
    add_column :categories, :category_url, :text
  end
end
