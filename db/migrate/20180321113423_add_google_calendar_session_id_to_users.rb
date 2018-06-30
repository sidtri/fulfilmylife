class AddGoogleCalendarSessionIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :gc_session_id, :string
  end
end
