class AddReferencesToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :references, :string
  end
end
