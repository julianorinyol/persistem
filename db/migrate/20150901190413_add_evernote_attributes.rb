class AddEvernoteAttributes < ActiveRecord::Migration
  def change
    add_column :notes, :update_sequence_number, :integer
    add_column :notebooks, :update_sequence_number, :integer
    add_column :users, :last_usn, :integer
  end
end
