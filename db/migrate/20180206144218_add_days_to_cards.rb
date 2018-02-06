class AddDaysToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :days, :integer
  end
end
