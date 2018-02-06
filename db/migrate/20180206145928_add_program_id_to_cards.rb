class AddProgramIdToCards < ActiveRecord::Migration[5.0]
  def change
    add_reference :cards, :program, foreign_key: true
  end
end
