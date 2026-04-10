class CreateBlocks < ActiveRecord::Migration[8.1]
  def change
    create_table :blocks do |t|
      t.string :identifier, null: false
      t.integer :floors, null: false
      t.integer :units_per_floor, null: false

      t.timestamps
    end

    add_index :blocks, :identifier, unique: true
  end
end