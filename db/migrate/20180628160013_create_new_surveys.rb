class CreateNewSurveys < ActiveRecord::Migration[5.0]
  def change
    create_table :new_surveys do |t|
      t.references :card, foreign_key: true
      t.string :question_id
      t.string :answer

      t.timestamps
    end
  end
end
