class CreateUnits < ActiveRecord::Migration[8.1]
  def change
    create_table :units do |t|
      t.references :block, null: false, foreign_key: true
      t.integer :floor, null: false
      t.integer :number, null: false
      t.string :identifier, null: false

      t.timestamps
    end

    add_index :units, :identifier, unique: true
  end
end