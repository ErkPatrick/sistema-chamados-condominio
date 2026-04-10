class CreateAttachments < ActiveRecord::Migration[8.1]
  def change
    create_table :attachments do |t|
      t.references :ticket, null: false, foreign_key: true
      t.string :file, null: false

      t.timestamps
    end
  end
end