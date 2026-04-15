class RemoveFileColumnFromAttachments < ActiveRecord::Migration[8.1]
  def change
    remove_column :attachments, :file, :string
  end
end