class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :title
      t.text :wikipedia, limit: 16777215

      t.timestamps null: false
    end
  end
end
