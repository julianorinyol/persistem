class AddNotebookGuidToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :notebook_guid, :string
  end
end
