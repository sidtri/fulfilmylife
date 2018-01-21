class AddParsedContentToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :parsed_content, :text
  end
end
