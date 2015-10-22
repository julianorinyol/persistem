class AddSyncableToNotebook < ActiveRecord::Migration
  def change
    add_column :notebooks, :syncable, :boolean, :default => true
    add_column :notes, :syncable, :boolean, :default => true
  end
end
