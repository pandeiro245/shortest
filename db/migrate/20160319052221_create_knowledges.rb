class CreateKnowledges < ActiveRecord::Migration
  def change
    create_table :knowledges do |t|
      t.references :word, index: true, foreign_key: true
      t.integer :tweet_id, index: true

      t.timestamps null: false
    end
  end
end
