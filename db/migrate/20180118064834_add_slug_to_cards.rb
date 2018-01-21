class AddSlugToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :slug, :string
  end
end
