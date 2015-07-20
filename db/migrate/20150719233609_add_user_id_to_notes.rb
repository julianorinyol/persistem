class AddUserIdToNotes < ActiveRecord::Migration
  def change
    add_reference :notes, :user, index: false, foreign_key: true
  end
end
