class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.string :photo
      t.references :dish, null: true, foreign_key: false

      t.timestamps
    end
  end
end
