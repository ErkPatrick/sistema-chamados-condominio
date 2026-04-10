class CreateTicketTypes < ActiveRecord::Migration[8.1]
  def change
    create_table :ticket_types do |t|
      t.string :title, null: false
      t.integer :sla_hours, null: false

      t.timestamps
    end

    add_index :ticket_types, :title, unique: true
  end
end