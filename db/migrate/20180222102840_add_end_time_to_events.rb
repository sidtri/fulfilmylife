class AddEndTimeToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :end_time, :datetime
    add_reference :events, :card, foreign_key: true
  end
end
