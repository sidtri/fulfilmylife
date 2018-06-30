class AddActiveToPrograms < ActiveRecord::Migration[5.0]
  def change
    add_column :programs, :active, :boolean, default: false
  end
end
