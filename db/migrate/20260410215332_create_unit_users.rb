class CreateUnitUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :unit_users do |t|
      t.references :unit, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :unit_users, [:unit_id, :user_id], unique: true
  end
end