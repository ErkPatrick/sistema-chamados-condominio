class CreateTickets < ActiveRecord::Migration[8.1]
  def change
    create_table :tickets do |t|
      t.references :unit, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :ticket_type, null: false, foreign_key: true
      t.references :ticket_status, null: false, foreign_key: true
      t.text :description, null: false
      t.datetime :opened_at, null: false
      t.datetime :closed_at

      t.timestamps
    end
  end
end