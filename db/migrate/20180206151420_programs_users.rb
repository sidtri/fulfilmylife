class ProgramsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :programs_users, id: false do |t|
      t.belongs_to :program, index: true
      t.belongs_to :user, index: true
    end
  end
end
