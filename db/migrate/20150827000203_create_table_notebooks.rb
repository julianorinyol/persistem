class CreateTableNotebooks < ActiveRecord::Migration
  def change
    create_table :notebooks do |t|
      t.string :guid
      t.string :title
      t.integer :user_id
    end
  end
end
