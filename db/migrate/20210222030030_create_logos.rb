class CreateLogos < ActiveRecord::Migration[6.0]
  def change
    create_table :logos do |t|
      t.string :photo
      t.references :restaurant, null: true, foreign_key: false
      t.timestamps
    end
  end
end
