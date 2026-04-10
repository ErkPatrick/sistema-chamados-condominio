class CreateTicketStatuses < ActiveRecord::Migration[8.1]
  def change
    create_table :ticket_statuses do |t|
      t.string :name, null: false
      t.boolean :is_default, null: false, default: false
      t.boolean :is_final, null: false, default: false

      t.timestamps
    end

    add_index :ticket_statuses, :name, unique: true
  end
end