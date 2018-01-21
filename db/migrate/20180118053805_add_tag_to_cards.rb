class AddTagToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :tag, :integer
  end
end
