class CreateTableNotebooks < ActiveRecord::Migration
  def change
    create_table :notebooks do |t|
      t.string :guid
      t.string :title
    end
  end
end
