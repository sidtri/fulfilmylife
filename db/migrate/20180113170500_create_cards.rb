class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.string :title
      t.string :sub_title
      t.string :total_time
      t.string :content

      t.timestamps
    end
  end
end
