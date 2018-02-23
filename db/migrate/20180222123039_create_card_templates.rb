class CreateCardTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :card_templates do |t|
      t.string :name
      t.references :card, foreign_key: true
      t.references :event, foreign_key: true
      t.references :program, foreign_key: true

      t.timestamps
    end
  end
end
