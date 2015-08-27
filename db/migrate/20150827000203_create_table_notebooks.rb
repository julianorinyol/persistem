class CreateTableNotebooks < ActiveRecord::Migration
  def change
    create_table :notebooks do |t|
      t.integer :guid
      t.string :title
    end
  end
end
